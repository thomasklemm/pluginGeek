source 'https://rubygems.org'

# Ruby Version on Heroku
ruby '1.9.3'

# Puma (App Server)
gem 'puma', '>= 2.0.0.b4'

# Rails
gem 'rails', '3.2.11'

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
gem 'omniauth-github' #, github: 'intridea/omniauth-github' # use gem version instead

# Sidekiq & Sinatra (for Sidekiq Web Interface)
gem 'sidekiq'
gem 'sinatra', :require => false

# Cache Digests (Watch Progress of this gem!)
gem 'cache_digests'

# Formtastic (Form Markup)
gem 'formtastic'

# Audited (Model Versioning and Auditing)
gem 'audited-activerecord', '~> 3.0'

# Figaro (Managing credentials)
gem 'figaro'

# New Relic (Server Monitoring)
gem 'newrelic_rpm'

# Closure Tree (Nesting Structures)
gem 'closure_tree'

# Dynamic Form (Display validation error messages)
gem 'dynamic_form'

# HoneyBadger (Error catching in production)
gem 'honeybadger'

# Production Gems
group :production do
  # Memcached on Heroku
  gem 'memcachier'
  gem 'dalli'
end

# Gems used only for assets and not required
#   in production environments by default.
group :assets do
  # Stylesheets
  # Sass
  gem 'sass', '>= 3.2.1'
  gem 'sass-rails'

  # Compass
  gem 'compass-rails'

  # Bourbon (SASS Mixins)
  gem 'bourbon'

  # Neat (Semantic Grids)
  gem 'neat'

  # Javascripts
  gem 'coffee-rails'
  gem 'uglifier'
end

# Development Gems
group :development do
  # Heroku (Custom Deployment Rake Tasks)
  gem 'heroku'
  # gem 'taps'    # for rake production:pull_db, has outdated dependencies
  # gem 'sqlite3' # for rake production:pull_db, has outdated dependencies

  # Annotate Models (Schema Info for Models and Routes)
  # master is currently 2.6.0.beta1; gem has not received updates in a while
  gem 'annotate', github: 'ctran/annotate_models'

  # Pry (IRB Replacement)
  gem 'pry-rails'
  gem 'pry-remote'

  # Letter Opener (Preview ActionMailer Emails in Development)
  gem 'letter_opener'

  # Quiet Assets (Mute Asset Log Messages in Development)
  gem 'quiet_assets'

  # Lol DBA (Find missing indexes)
  # gem 'lol_dba'

  # Bullet (Eager Loading Notification)
  gem 'bullet'

  # Better Errors (REPL Debug)
  gem 'better_errors'
  gem 'binding_of_caller'
end
