source 'https://rubygems.org'

# Ruby Version on Heroku
ruby '1.9.3'

# Unicorn (App Server)
gem 'unicorn'

# Rails
gem 'rails', '3.2.8'

# Postgres Database Connector
gem 'pg'

# Gems used only for assets and not required
#   in production environments by default.
group :assets do
  # CSS
  gem 'sass', '3.2.0.alpha261'
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'zurb-foundation', '3.0.8'
  # Bourbon (SASS Mixins)
  gem 'bourbon'

  # JS
  gem 'coffee-rails'
  gem 'uglifier'
end

# jQuery Rails (jQuery Adapter for Rails)
gem 'jquery-rails'

# Production Gems
group :production do
  # Memcached on Heroku
  gem 'memcachier'
  gem 'dalli'

  # New Relic (Server Monitoring)
  gem 'newrelic_rpm'
end

# High Voltage (Static Pages)
gem 'high_voltage'

# Slim (Templating)
gem 'slim-rails'

# Friendly Id (Human-Readable IDs for ActiveRecord Models)
gem 'friendly_id'

# Acts as Taggable On (Tagging for ActiveRecord Models)
gem 'acts-as-taggable-on'

# HTTPClient (MT-Safe HTTP Client)
gem 'httpclient'

# Sorcery (User Authentication)
gem 'sorcery', '~> 0.7.12'

# Redcarpet (Markdown Parser)
gem 'redcarpet'

# Github API
# gem 'github_api'

# Sidekiq & Sinatra (for Sidekiq Web Interface)
gem 'sidekiq'
gem 'sinatra', require: false

# Seedbank (Seed Structure)
gem 'seedbank'

# Development Gems
group :development do
  # Heroku (Custom Deployment Rake Tasks)
  gem 'heroku'

  # Annotate Models (Schema Info for Models and Routes)
  gem 'annotate', '>=2.5.0', group: :development

  # Pry (IRB Replacement)
  gem 'pry-rails'
  gem 'pry-remote'

  # Letter Opener (Preview ActionMailer Emails in Development)
  gem 'letter_opener'

  # Quiet Assets (Mute Asset Log Messages in Development)
  gem 'quiet_assets'

  # Rails Footnotes (Debug Footnotes on every Page in Development)
  # gem 'rails-footnotes', '>= 3.7.8', group: :development
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'