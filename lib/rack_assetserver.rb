require 'time'
require 'rack/utils'
require 'rack/mime'

module Rack
  class AssetServer
    def initialize(app, options={})
      @app = app
      @urls = options[:urls] || ["/favicon.ico"]
      @index = options[:index]
      root = options[:root] || Dir.pwd
      headers = options[:headers]
      @file_server = Rack::AssetFile.new(root, headers)
    end

    def overwrite_file_path(path)
      @urls.kind_of?(Hash) && @urls.key?(path) || @index && path =~ /\/$/
    end

    def route_file(path)
      @urls.kind_of?(Array) && @urls.any? { |url| path.index(url) == 0 }
    end

    def can_serve(path)
      route_file(path) || overwrite_file_path(path)
    end

    def call(env)
      path = env["PATH_INFO"]

      if can_serve(path)
        env["PATH_INFO"] = (path =~ /\/$/ ? path + @index : @urls[path]) if overwrite_file_path(path)
        @file_server.call(env)
      else
        @app.call(env)
      end
    end
  end

  class AssetFile
    SEPS = Regexp.union(*[::File::SEPARATOR, ::File::ALT_SEPARATOR].compact)
    ALLOWED_VERBS = %w[GET HEAD]

    attr_accessor :root
    attr_accessor :path
    attr_accessor :cache_control

    alias :to_path :path

    def initialize(root, headers = nil)
      @root = root
      @headers = headers
      raise headers.inspect
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
      if headers
        headers.each do |key, value|
          response[1][key] = value
        end
      end

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