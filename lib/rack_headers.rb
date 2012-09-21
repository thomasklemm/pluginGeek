require 'rack/utils'

# Set custom HTTP Headers for based on rules:
#
#     use Rack::Headers, :root => 'public',
#         :header_rules => [
#           [rule, {header_field => content, header_field => content}],
#           [rule, {header_field => content}]
#         ]
#
#  Rules for selecting files:
#
#  1) All files
#     Provide the :all symbol
#     :all => Matches every file
#
#  2) Folders
#     Provide the folder path as a string
#     '/folder' or '/folder/subfolder' => Matches files in a certain folder
#
#  3) File Extensions
#     Provide the file extensions as an array
#     ['css', 'js'] or %w(css js) => Matches files ending in .css or .js
#
#  4) Regular Expressions / Regexp
#     Provide a regular expression
#     %r{\.(?:css|js)\z} => Matches files ending in .css or .js
#     /\.(?:eot|ttf|otf|woff|svg)\z/ => Matches files ending in
#       the most common web font formats (.eot, .ttf, .otf, .woff, .svg)
#       Note: This Regexp is available as a shortcut, using the :fonts rule
#
#  5) Font Shortcut
#     Provide the :fonts symbol
#     :fonts => Uses the Regexp rule stated right above to match all common web font endings
#
#  Rule Ordering:
#    Rules are applied in the order that they are provided.
#    List rather general rules above special ones.
#
#  Complete example use case including HTTP header rules:
#
#     use Rack::Headers, :root => 'public',
#         :header_rules => [
#           # Cache all static files in public caches (e.g. Rack::Cache)
#           #  as well as in the browser
#           [:all, {'Cache-Control' => 'public, max-age=31536000'}],
#
#           # Provide web fonts with cross-origin access-control-headers
#           #  Firefox requires this when serving assets using a Content Delivery Network
#           [:fonts, {'Access-Control-Allow-Origin' => '*'}]
#         ]

module Rack
  class Headers

    def initialize(app, opts={})
      @app = app

      asset_path = defined? Rails ? (Rails.application.config.assets.prefix || '/assets') : '/assets'
      @asset_path = opts.fetch(:path, asset_path)

      header_rules = defined? Rails ? (Rails.application.config.assets.header_rules || []) : []
      @header_rules = opts.fetch(:header_rules, header_rules)
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      status, @headers, response = @app.call(env)
      @path = ::Rack::Utils.unescape(env['PATH_INFO'])

      # Set HTTP Headers
      set_headers if @path.start_with?(@asset_path)

      [status, @headers, response]
    end

    # Convert HTTP header rules to HTTP headers
    def set_headers
      @header_rules.each do |rule, headers|
        apply_rule(rule, headers)
      end
    end

    def apply_rule(rule, headers)
      case rule
      when :all    # All files
        set_header(headers)
      when :fonts  # Fonts Shortcut
        set_header(headers) if @path.match(/\.(?:ttf|otf|eot|woff|svg)\z/)
      when String  # Folder
        path = ::Rack::Utils.unescape(@path)
        set_header(headers) if (path.start_with?(rule) || path.start_with?('/' + rule))
      when Array   # Extension/Extensions
        extensions = rule.join('|')
        set_header(headers) if @path.match(/\.(#{extensions})\z/)
      when Regexp  # Flexible Regexp
        set_header(headers) if @path.match(rule)
      else
      end
    end

    def set_header(headers)
      headers.each { |field, content| @headers[field] = content }
    end
  end
end
