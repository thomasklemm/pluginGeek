source 'https://rubygems.org'

# Ruby version on Heroku
ruby '2.0.0'

# App server
gem 'passenger'

# The latest and greatest Rails (or has the world been progressing?)
gem 'rails', '~> 4.0.4'

# Postgres database
gem 'pg'

# Coffeescript and unobtrusive jQuery
gem 'coffee-rails'
gem 'jquery-rails'
gem 'uglifier'

# Sass stylesheets
gem 'sass-rails', '~> 4.0.2'

# Threadsafe HTTP requests
gem 'httpclient'

# User authentication
gem 'devise', '>= 3.0.0'

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
  gem 'rspec-rails'
  gem 'debugger'
end

group :test do
  # Cleans your test database
  gem 'database_cleaner'

  # Fabricate objects instead of using fixtures
  #  Great also for generating seed data
  gem 'fabrication'

  # Cool rspec matchers
  gem 'shoulda-matchers'

  # Mock objects
  gem 'mocha'

  # Time travelling
  gem 'timecop'

  # Headless javascript driver
  gem 'capybara-webkit'

  # Opens the website in your favorite browser
  # in case of a red feature
  gem 'launchy'

  # Stub http requests
  gem 'webmock'
  gem 'vcr'
end

group :production do
  # Heroku gem
  gem 'rails_12factor'

  # Memcached provider
  gem 'memcachier'

  # Stats for your app
  gem 'newrelic_rpm'
  
  # Shorten logs
  gem 'lograge'

  # Email in case of exception
  gem 'exception_notification'
end
