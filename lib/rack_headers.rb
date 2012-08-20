require 'rack/utils'

module Rack
  class Headers

    def initialize(app, path, options={})
      @app = app
      @path = path
      @rules = options.fetch(:rules, {})
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      @response = @app.call(env)
      set_headers if env['PATH_INFO'].match @path
      @response
    end

    def set_headers
      @rules.each do |rule, headers|
        case rule
        when :global # Global
          set_header(headers)
        when :fonts  # Fonts Shortcut
          set_header(headers) if @path.match %r{\.(?:ttf|otf|eot|woff|svg)\z}
        when String  # Folder
          path = ::Rack::Utils.unescape(@path) # TEST IF NESCESSARY
          set_header(result) if
            (path.start_with? rule || path.start_with?('/' + rule))
        when Array   # Extension/Extensions
          extensions = rule.join('|')
          set_header(result) if @path.match %r{\.(#{extensions})\z}
        when Regexp  # Flexible Regexp
          set_header(result) if @path.match rule
        else
        end
      end
    end

    def set_header(headers)
      headers.each { |field, content| @response[1][field] = content }
    end
  end
end