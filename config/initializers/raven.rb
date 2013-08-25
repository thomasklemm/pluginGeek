# Sentry Ruby Client
if Rails.env.production?
  require 'raven'

  Raven.configure do |config|
    config.dsn = ENV['SENTRY_URL'] if ENV['SENTRY_URL']
    config.environments = %w[ production ]
  end
end
