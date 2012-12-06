source 'https://rubygems.org'

# Ruby Version on Heroku
ruby '1.9.3'

# Unicorn (App Server)
gem 'unicorn'

# Rails
gem 'rails', '3.2.9'

# Postgres Database Connector
gem 'pg'

# jQuery Rails (jQuery Adapter for Rails)
gem 'jquery-rails'

# High Voltage (Static Pages)
gem 'high_voltage'

# Slim (Templating)
gem 'slim-rails'

# Friendly Id (Human-Readable IDs for ActiveRecord Models)
gem 'friendly_id'

# HTTPClient (MT-Safe HTTP Client)
gem 'httpclient'

# Sorcery (User Authentication)
gem 'sorcery', '~> 0.7.12'

# Redcarpet (Markdown Parser)
gem 'redcarpet'

# Sidekiq & Sinatra (for Sidekiq Web Interface)
gem 'sidekiq'
gem 'sinatra', :require => false

# Cache Digests (Watch Progress of this gem!)
gem 'cache_digests'

# Flag Shih Tzu (Bit fields for ActiveRecord)
gem 'flag_shih_tzu'

# Formtastic (Form Markup)
gem 'formtastic'

# Audited (Model Versioning and Auditing)
gem 'audited-activerecord', '~> 3.0'

# Production Gems
group :production do
  # Memcached on Heroku
  gem 'memcachier'
  gem 'dalli'

  # New Relic (Server Monitoring)
  gem 'newrelic_rpm'
end

# Gems used only for assets and not required
#   in production environments by default.
group :assets do
  ##
  # CSS
  # Sass
  gem 'sass', '>= 3.2.1'
  gem 'sass-rails'
  # Compass
  gem 'compass-rails'
  # Bourbon (sass mixin library)
  gem 'bourbon'
  # Zurb Foundation (design framework)
  gem 'zurb-foundation', '>= 3.0.9'

  ##
  # JS
  gem 'coffee-rails'
  gem 'uglifier'
end

# Development Gems
group :development do
  # Heroku (Custom Deployment Rake Tasks)
  gem 'heroku'

  # Annotate Models (Schema Info for Models and Routes)
  gem 'annotate', '>=2.5.0'

  # Pry (IRB Replacement)
  gem 'pry-rails'
  gem 'pry-remote'

  # Letter Opener (Preview ActionMailer Emails in Development)
  gem 'letter_opener'

  # Quiet Assets (Mute Asset Log Messages in Development)
  gem 'quiet_assets'

  # Lol DBA (Find missing indexes)
  gem 'lol_dba'

  # Bullet (Eager Loading Notification)
  gem 'bullet'
end

# Test Gems
# Source: http://stackoverflow.com/questions/7628654/using-minitest-in-rails#comment12068363_9221625
group :test do
  # Minitest (latest gem version)
  gem 'minitest'

  # Capybara for integration test
  gem 'capybara'

  # Turn for nice test output
  # gem 'turn'

  # Guard for watching file changes
  # and running tests automatically
  gem 'guard-minitest'

  # Factory Girl for fabricating object instances
  gem 'factory_girl_rails'
end
