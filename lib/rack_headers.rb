require 'rack/utils'

module Rack
  class Headers

    def initialize(app, options={})
      @app = app

      default_path = Rails.application.config.assets.prefix || '/assets'
      @asset_path = options.fetch(:path, default_path)

      default_rules = Rails.application.config.assets.header_rules || {}
      @rules = options.fetch(:header_rules, default_rules)
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      status, @headers, response = @app.call(env)
      @path = ::Rack::Utils.unescape(env['PATH_INFO'])

      if @path.start_with?(@asset_path)
        set_headers
      end

      [status, @headers, response]
    end

    def set_headers
      @rules.each do |rule, headers|
        case rule
        when :global # Global
          set_header(headers)
        when :fonts  # Fonts Shortcut
          set_header(headers) if @path.match %r{\.(?:ttf|otf|eot|woff|svg)\z}
        when Array   # Extension/Extensions
          extensions = rule.join('|')
          set_header(result) if @path.match %r{\.(#{extensions})\z}
        when String  # Folder
          set_header(result) if
            (@path.start_with? rule || @path.start_with?('/' + rule))
        when Regexp  # Flexible Regexp
          set_header(result) if @path.match rule
        else
        end
      end
    end

    def set_header(headers)
      headers.each { |field, content| @headers[field] = content }
    end
  end
end