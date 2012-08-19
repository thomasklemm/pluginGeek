require 'time'
require 'rack/utils'
require 'rack/mime'
require 'active_support/core_ext/uri'

module ActionDispatch
  # ActionDispatch::Assets serves static files if it can find them precompiled
  # and will otherwise send the request onwards in the Rails stack.
  #
  #   ActionDispatch::Assts allows to set custom headers based on rules.
  #
  #   # Symbol Shortcuts
  #   :global  => { field => content }  # Symbol :global (will match all files)
  #   :fonts   => { field => content }  # Symbol :fonts (will match files with common webfonts extensions)
  #
  #   # Extensions
  #   # provided as an array
  #   ['css', 'js'] => { field => content }  # Array (will match extensions)
  #   %w(css js)    => { field => content }  # Array (will match extensions)
  #
  #   # Folder
  #   # provided as a string
  #   # Note: Take into account that the root folder is '/public'
  #   #       and calculate your routes from there
  #   '/folder' => { field => content }
  #   '/assets/application.js' => { field => content }
  #
  #   # Regexp
  #   # For example all files with extensions css or js
  #   # This approach is very flexible
  #   /\.(css|js)\z/ => { field => content }  # Regexp (flexible)
  #
  class Assets
    def initialize(app, path, options={})
      @app = app
      @header_rules = options[:header_rules] || {}
      @file_handler = FileHandler.new(path, header_rules: @header_rules)
    end

    def call(env)
      case env['REQUEST_METHOD']
      when 'GET', 'HEAD'
        path = env['PATH_INFO'].chomp('/')
        if match = @file_handler.match?(path)
          env["PATH_INFO"] = match
          return @file_handler.call(env)
        end
      end

      @app.call(env)
    end
  end

  class FileHandler
    def initialize(root, options={})
      @root          = root.chomp('/')
      @compiled_root = /^#{Regexp.escape(root)}/
      @header_rules  = options[:header_rules] || {}
      @headers       = {}
      @file_server   = File.new(@root, headers: @headers)
    end

    def match?(path)
      path = path.dup

      full_path = path.empty? ? @root : File.join(@root, escape_glob_chars(unescape_path(path)))
      paths = "#{full_path}#{ext}"

      matches = Dir[paths]
      match = matches.detect { |m| File.file?(m) }
      if match
        match.sub!(@compiled_root, '')
        ::Rack::Utils.escape(match)
      end
    end

    def call(env)
      set_headers
      @file_server.call(env)
    end

    def ext
      @ext ||= begin
        ext = ::ActionController::Base.page_cache_extension
        "{,#{ext},/index#{ext}}"
      end
    end

    def unescape_path(path)
      URI.parser.unescape(path)
    end

    def escape_glob_chars(path)
      path.force_encoding('binary') if path.respond_to? :force_encoding
      path.gsub(/[*?{}\[\]]/, "\\\\\\&")
    end

    # Convert header rules to headers
    def set_headers
      @header_rules.each do |rule, result|
        case rule
        when :global
          set_header(result)
        when :fonts
          set_header(result) if @path.match(/\.(ttf|otf|eot|woff|svg)\z/)
        when Regexp
          set_header(result) if @path.match(rule)
        when Array
          # Extensions
          extensions = rule.join('|')
          # TODO: test
          set_header(result) if @path.match(/\.(#{extensions})\z/)
        when String
          # Folder
          set_header(result) if @path.gsub(@root, '').start_with?(rule)
        else
        end
      end
    end

    def set_header(result)
      result.each do |field, content|
        @headers[field] = content
      end
    end
  end

  class File
    SEPS = Regexp.union(*[::File::SEPARATOR, ::File::ALT_SEPARATOR].compact)
    ALLOWED_VERBS = %w[GET HEAD]

    attr_accessor :root, :path, :headers

    alias :to_path :path

    def initialize(root, options={})
      @root = root
      @headers = options[:headers] || {}
    end

    def call(env)
      dup._call(env)
    end

    F = ::File

    def _call(env)
      unless ALLOWED_VERBS.include? env["REQUEST_METHOD"]
        return fail(405, "Method Not Allowed")
      end

      path_info = Utils.unescape(env["PATH_INFO"])
      parts = path_info.split SEPS

      parts.inject(0) do |depth, part|
        case part
        when '', '.'
          depth
        when '..'
          return fail(404, "Not Found") if depth - 1 < 0
          depth - 1
        else
          depth + 1
        end
      end

      @path = F.join(@root, *parts)

      available = begin
        F.file?(@path) && F.readable?(@path)
      rescue SystemCallError
        false
      end

      if available
        set_headers
        serving(env)
      else
        fail(404, "File not found: #{path_info}")
      end
    end

    def serving(env)
      last_modified = F.mtime(@path).httpdate
      return [304, {}, []] if env['HTTP_IF_MODIFIED_SINCE'] == last_modified
      response = [
        200,
        {
          "Last-Modified"  => last_modified,
          "Content-Type"   => Mime.mime_type(F.extname(@path), 'text/plain')
        },
        env["REQUEST_METHOD"] == "HEAD" ? [] : self
      ]

      # Set headers
      @headers.each { |field, content| response[1][field] = content } if @headers

      # NOTE:
      #   We check via File::size? whether this file provides size info
      #   via stat (e.g. /proc files often don't), otherwise we have to
      #   figure it out by reading the whole file into memory.
      size = F.size?(@path) || Utils.bytesize(F.read(@path))

      ranges = Rack::Utils.byte_ranges(env, size)
      if ranges.nil? || ranges.length > 1
        # No ranges, or multiple ranges (which we don't support):
        # TODO: Support multiple byte-ranges
        response[0] = 200
        @range = 0..size-1
      elsif ranges.empty?
        # Unsatisfiable. Return error, and file size:
        response = fail(416, "Byte range unsatisfiable")
        response[1]["Content-Range"] = "bytes */#{size}"
        return response
      else
        # Partial content:
        @range = ranges[0]
        response[0] = 206
        response[1]["Content-Range"] = "bytes #{@range.begin}-#{@range.end}/#{size}"
        size = @range.end - @range.begin + 1
      end

      response[1]["Content-Length"] = size.to_s
      response
    end

    def each
      F.open(@path, "rb") do |file|
        file.seek(@range.begin)
        remaining_len = @range.end-@range.begin+1
        while remaining_len > 0
          part = file.read([8192, remaining_len].min)
          break unless part
          remaining_len -= part.length

          yield part
        end
      end
    end

    private

    def fail(status, body)
      body += "\n"
      [
        status,
        {
          "Content-Type" => "text/plain",
          "Content-Length" => body.size.to_s,
          "X-Cascade" => "pass"
        },
        [body]
      ]
    end

  end
end
