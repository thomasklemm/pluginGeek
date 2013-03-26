source 'https://rubygems.org'

# Ruby Version on Heroku
ruby '1.9.3'

# Puma (App Server)
gem 'puma', '2.0.0.b6'

# Rails
gem 'rails', '3.2.13'

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

# Redcarpet (Markdown Parser)
gem 'redcarpet'

# Devise (User Authentication)
gem 'devise'

# Omniauth for Github (oAuth Authentication)
gem 'omniauth'
gem 'omniauth-github'

# Sidekiq and Sinatra (for Sidekiq Web Interface)
gem 'sidekiq'
gem 'sinatra', :require => false

# Cache Digests (Watch Progress of this gem!)
gem 'cache_digests'

# Audited (Model Versioning and Auditing)
gem 'audited-activerecord', '~> 3.0'

# Figaro (Managing credentials)
gem 'figaro'

# Closure Tree (Nesting Structures)
gem 'closure_tree'

# Dynamic Form (Display validation error messages)
gem 'dynamic_form'

# Intercom (Communicating with users)
gem 'intercom-rails', '~> 0.2.14'

# Lograge (Logging)
gem 'lograge'

# Rack Timeout
gem 'rack-timeout'

# Draper (Decorators)
gem 'draper'

# Formtastic (Forms)
gem 'formtastic'

# Strong parameters (Form parameter filtering)
gem 'strong_parameters'

# Gems used only for assets and not required
#   in production environments by default.
group :assets do
  # Stylesheets
  # Sass and Compass
  gem 'sass-rails'
  gem 'compass-rails'

  # Bourbon (SASS Mixins)
  # Neat (Semantic Grids)
  gem 'bourbon'
  gem 'neat'

  # Javascripts
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do
  # Annotate Models (Adds schema info for models to matching files)
  #  Note: master is currently 2.6.0.beta1; gem has not received updates in a while
  gem 'annotate', github: 'ctran/annotate_models'

  # Pry (A great console, replacement for IRB in development)
  gem 'pry-rails'

  # Letter Opener (Previews ActionMailer emails in development)
  gem 'letter_opener'

  # Quiet Assets (Mutes asset pipeline logs in development)
  gem 'quiet_assets'

  # Bullet (Finds N+1 queries and more in development)
  gem 'bullet'

  # Better Errors (Debug pages in development)
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'bourne', require: false
  gem 'capybara-webkit', '>= 0.14.1'
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
end

group :staging, :production do
  # Memcached using Memcachier on Heroku
  gem 'memcachier'
  gem 'dalli'

  # New Relic (Server monitoring)
  gem 'newrelic_rpm'

  # Sentry (Error reporting in production)
  gem 'sentry-raven', github: 'getsentry/raven-ruby'
end
