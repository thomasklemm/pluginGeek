source 'https://rubygems.org'

# Ruby Version on Heroku
ruby '2.0.0'

# Phusion Passenger (App server)
gem 'passenger'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.2'

# Postgres Database Connector
gem 'pg'

# High Voltage (Static Pages)
gem 'high_voltage'

gem 'coffee-rails'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'

# Slim templating language
gem 'slim-rails'

# Use SASS for stylesheets
gem 'sass-rails'
gem 'bootstrap-sass', '~> 3.1.0'

# HTTPClient (MT-Safe HTTP Client)
gem 'httpclient'

# Devise (User Authentication)
gem 'devise', '>= 3.0.0'

# Omniauth for Github (oAuth Authentication)
gem 'omniauth'
gem 'omniauth-github'

# Sidekiq (Background jobs)
gem 'sidekiq'

# Sinatra (for Sidekiq web interface)
gem 'sinatra'

# Figaro (Managing credentials)
gem 'figaro'

# Draper (Presenters / Decorators)
gem 'draper'

# Pundit (Authorization)
gem 'pundit'

# Redcarpet (Markdown parser)
gem 'redcarpet'

# Memcached
gem 'dalli'

# MiniProfiler
gem 'rack-mini-profiler'

# Use debugger
gem 'debugger', group: [:development, :test]

# Pry Console
gem 'pry'
gem 'pry-rails', group: :development

group :development do
  gem 'letter_opener'
  gem 'quiet_assets'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'guard-livereload'
  gem 'rack-livereload'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'

  gem 'fabrication'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers', branch: 'dp-rails-four'

  gem 'mocha'
  gem 'timecop'

  gem 'simplecov', require: false
  gem 'coveralls', require: false

  gem 'capybara-webkit'
  gem 'launchy'

  gem 'webmock'
  gem 'vcr'
end

group :staging, :production do
  gem 'rails_12factor'
  gem 'memcachier'
  gem 'newrelic_rpm'
  gem 'sentry-raven', github: 'getsentry/raven-ruby'
  gem 'lograge'
end
