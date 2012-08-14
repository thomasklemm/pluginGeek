Knight::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  # Source: https://devcenter.heroku.com/articles/rack-cache-memcached-static-assets-rails31
  # Insert ActionDispatch::Static here, delete later
  config.serve_static_assets = true
  # Cache Control Headers (might be irrelevant here)
  config.static_cache_control = 'public, max-age=1337000'

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # Review: prefix with http:// or not
  config.action_controller.asset_host = 'http://ruby.knight.io'
  # config.action_controller.asset_host = 'http://d2ishtm40wfhei.cloudfront.net'

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w( application_head.js application_body.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  ###
  #   Caching
  ###
  # Explicit Requires
  require 'memcachier'
  require 'dalli'
  require 'rack/cache'

  # Use a different cache store in production
  # Cache Store for Fragment Caching
  config.cache_store = :dalli_store

  # HTTP Caching
  config.action_dispatch.rack_cache = {
    :metastore    => Dalli::Client.new,
    :entitystore  => 'file:tmp/cache/rack/body',
    :allow_reload => false
  }

  # Serve Static Assets
  if !Rails.env.development? && !Rails.env.test?
    config.middleware.insert_before Rack::Cache, Rack::Static, urls: [config.assets.prefix], root: 'public', cache_control: 'public, max-age=13370'
    config.middleware.delete ActionDispatch::Static
  end
end
