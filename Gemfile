source 'https://rubygems.org'

# Ruby Version on Heroku
ruby '1.9.3'

# Unicorn (App Server)
gem 'unicorn'

# Rails
gem 'rails', '3.2.6'

# Postgres Database Connector
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'compass-rails' # some syntax in the foundation stylesheets seems to be only compatible with compass
  gem 'zurb-foundation', '3.0.5' # specifying nescessary versions for sass and compass
  gem 'coffee-rails'
  gem 'uglifier'
  # Bourbon (SASS Mixins)
  gem 'bourbon', '~> 2.1.0' # next major version deprecates border-radius mixin
  # jQuery Rails (jQuery Adapter for Rails)
  gem 'jquery-rails'
end

# High Voltage (Static Pages)
gem 'high_voltage'

# Slim (Templating)
gem 'slim-rails'

# Letter Opener (Preview ActionMailer Emails in Development)
gem 'letter_opener', group: :development

# Quiet Assets (Mute Asset Log Messages in Development)
gem 'quiet_assets', group: :development

# Rails Footnotes (Debug Footnotes on every Page in Development)
gem 'rails-footnotes', '>= 3.7.5.rc4', group: :development

# Friendly Id (Human-Readable IDs for ActiveRecord Models)
gem 'friendly_id'

# Acts as Taggable On (Tagging for ActiveRecord Models)
gem 'acts-as-taggable-on'

# Excon (HTTP Client)
gem 'excon'

# Pry (IRB Replacement)
gem 'pry-rails', group: :development
gem 'pry-remote', group: :development

# Sorcery (User Authentication)
gem 'sorcery', '~> 0.7.12'

# Redcarpet (Markdown Parser)
gem 'redcarpet'

# New Relic (Server Monitoring)
gem 'newrelic_rpm', group: :production

# Github API
gem 'github_api'

# Annotate Models (Schema Info for Models and Routes)
gem 'annotate', '>=2.5.0.pre1', group: :development

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'