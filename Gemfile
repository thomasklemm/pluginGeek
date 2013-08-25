source 'https://rubygems.org'

# Ruby Version on Heroku
ruby '2.0.0'

# Puma (App server)
gem 'puma'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Postgres Database Connector
gem 'pg'

# High Voltage (Static Pages)
gem 'high_voltage'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# jQuery Rails (jQuery adapter for Rails)
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Slim (Templating)
gem 'slim-rails'

# Friendly Id (Human-Readable IDs for ActiveRecord Models)
gem 'friendly_id', github: 'norman/friendly_id'

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

# Cache Digests (Russian-Doll caching)
# gem 'cache_digests'

# Figaro (Managing credentials)
gem 'figaro'

# Closure Tree (Nesting Structures)
gem 'closure_tree'

# Intercom (Communicating with users)
gem 'intercom-rails', '~> 0.2.17'

# Rack Timeout
gem 'rack-timeout'

# Draper (Presenters / Decorators)
gem 'draper'

# Strong parameters (Form parameter filtering)
# gem 'strong_parameters'

# Pundit (Authorization)
gem 'pundit'

# Redcarpet (Markdown parser)
gem 'redcarpet'

# Peek (Stats and insights into a Rails app)
gem 'peek'
gem 'peek-pg'
gem 'peek-performance_bar'
gem 'peek-dalli'

# Bourbon (SASS Mixins)
# Neat (Semantic Grids)
gem 'bourbon'
gem 'neat'

# Use debugger
gem 'debugger', group: [:development, :test]

# Pry Console
gem 'pry'
gem 'pry-rails', group: :development

group :development do
  # Annotate Models (Adds schema info for models to matching files)
  #  Note: master is currently 2.6.0.beta1; gem has not received updates in a while
  # gem 'annotate', github: 'ctran/annotate_models'

  # Letter Opener (Previews ActionMailer emails in development)
  gem 'letter_opener'

  # Quiet Assets (Mutes asset pipeline logs in development)
  gem 'quiet_assets'

  # Better Errors (Debug pages in development)
  gem 'better_errors'
  gem 'binding_of_caller'

  # LiveReload
  gem 'guard-livereload'
  gem 'rack-livereload'

  # RailsPanel
  gem 'meta_request'

  # Optimize database queries
  # gem 'bullet'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers', branch: 'dp-rails-four'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'mocha'
  # gem 'bourne', require: false
  gem 'timecop'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'webmock'
  gem 'vcr'
end

group :staging, :production do
  # Heroku 12factor gem
  gem 'rails_12factor'

  # Memcached using Memcachier on Heroku
  gem 'memcachier'
  gem 'dalli'

  # New Relic (Server monitoring)
  gem 'newrelic_rpm'

  # Sentry (Error notifications)
  gem 'sentry-raven', github: 'getsentry/raven-ruby'

  # Lograge (Logging)
  gem 'lograge'

  # Rack Timeout
  # gem 'rack-timeout'
end
