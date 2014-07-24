source 'https://rubygems.org'

# Ruby version
ruby '2.1.2'

# App server
gem 'passenger'

# The latest and greatest Ruby on Rails
gem 'rails', '~> 4.1.4'

# Postgres database
gem 'pg'

# Coffeescript and unobtrusive jQuery
gem 'coffee-rails'
gem 'jquery-rails'
gem 'uglifier'

# Sass stylesheets
gem 'sass-rails', '~> 4.0.3'

# Threadsafe HTTP requests
gem 'httpclient'

# User authentication
gem 'devise'

# User authentication with oAuth
gem 'omniauth'
gem 'omniauth-github'

# Authorization logic
gem 'pundit'

# Manage credentials
gem 'figaro'

# Slim templates
gem 'slim-rails'

# Decorate records for the view layer
gem 'draper'

# Renders markdown
gem 'redcarpet'

# Memcached client
gem 'dalli'

# Where do all these database queries come from?
gem 'rack-mini-profiler'

# The pry console, a replacement for IRB
gem 'pry'
gem 'pry-rails', group: :development

# Static pages
gem 'high_voltage'

# Guarded method invocation
gem 'andand'

# Pagination
gem 'kaminari'

# Relative timestamps
gem 'local_time'

# Enhance select boxes
gem 'selectize-rails'

# JSON building
gem 'jbuilder'

group :development do
  # Opens emails in a new tab
  gem 'letter_opener'

  # Great error pages with a small console
  gem 'better_errors'
  gem 'binding_of_caller'

  # Reloads the app live
  #  Run: bundle exec guard
  gem 'guard-livereload'
  gem 'rack-livereload'

  # No need for asset requests in the logs
  gem 'quiet_assets'
end

group :development, :test do
  # The RSpec testing framework
  gem 'rspec-rails', '~> 3.0'

  # Faster spec startup times
  #  Run: spring rspec
  #       spring rspec spec/models/repo_spec.rb
  gem 'spring-commands-rspec'
end

group :test do
  # Cleans your test database
  gem 'database_cleaner'

  # Fabricate objects instead of using fixtures
  #  Great also for generating seed data
  gem 'fabrication'

  # Useful RSpec matchers
  gem 'shoulda-matchers', require: false

  # Time travelling
  gem 'timecop'

  # Opens the website in your favorite browser
  # in case of a red feature
  gem 'launchy'

  # Stub http requests
  gem 'webmock'
  gem 'vcr'

  # Form filling with Capybara
  gem 'formulaic'

  # Formerly in RSpec core
  gem 'rspec-collection_matchers'
end

group :production do
  # Heroku logging
  gem 'rails_12factor'

  # Memcached provider
  gem 'memcachier'

  # Stats for your app
  gem 'newrelic_rpm'
  
  # Shorten logs
  gem 'lograge'

  # Exception emails
  gem 'exception_notification'
end
