source 'https://rubygems.org'

# Ruby Version on Heroku
ruby '1.9.3'

# Puma (App Server)
gem 'puma', '>= 2.0.0'

# Rails
gem 'rails', '3.2.13'

# Postgres Database Connector
gem 'pg'

# High Voltage (Static Pages)
gem 'high_voltage'

# jQuery Rails (jQuery Adapter for Rails)
gem 'jquery-rails'

# Slim (Templating)
gem 'slim-rails'

# Friendly Id (Human-Readable IDs for ActiveRecord Models)
gem 'friendly_id'

# HTTPClient (MT-Safe HTTP Client)
gem 'httpclient'

# Devise (User Authentication)
gem 'devise'

# Omniauth for Github (oAuth Authentication)
gem 'omniauth'
gem 'omniauth-github'

# Sidekiq and Sinatra (for Sidekiq Web Interface)
gem 'sidekiq'
gem 'sinatra', :require => false

# Cache Digests (Russian-Doll caching)
gem 'cache_digests'

# Figaro (Managing credentials)
gem 'figaro'

# Closure Tree (Nesting Structures)
gem 'closure_tree'

# Intercom (Communicating with users)
gem 'intercom-rails', '~> 0.2.17'

# Rack Timeout
gem 'rack-timeout'

# Draper (Decorators)
gem 'draper'

# Strong parameters (Form parameter filtering)
gem 'strong_parameters'

# Pundit (Authorization)
gem 'pundit'

# Redcarpet (Markdown parser)
gem 'redcarpet'

# Peek (Stats and insights into a Rails app)
gem 'peek'
gem 'peek-pg'
gem 'peek-git'
gem 'peek-performance_bar'
gem 'peek-dalli'

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

  # Better Errors (Debug pages in development)
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'bourne', require: false
  gem 'timecop'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'webmock'
  gem 'vcr'
end

group :staging, :production do
  # Memcached using Memcachier on Heroku
  gem 'memcachier'
  gem 'dalli'

  # New Relic (Server monitoring)
  gem 'newrelic_rpm'

  # Sentry (Error notifications)
  gem 'sentry-raven', github: 'getsentry/raven-ruby'

  # Lograge (Logging)
  gem 'lograge'
end
