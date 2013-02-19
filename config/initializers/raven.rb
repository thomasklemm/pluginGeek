# Sentry Ruby Client
if Rails.env.production?
  require 'raven'

  Raven.configure do |config|
    config.dsn = ENV['SENTRY_URL']
  end
end
