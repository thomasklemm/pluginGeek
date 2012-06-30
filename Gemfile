source 'https://rubygems.org'
# Ruby Version on Heroku
ruby "1.9.3"

# Web server
# CHECK: Is this the right order in which to load things?
gem 'thin'

# Rails
gem 'rails', '3.2.5'

# Postgres DB on Heroku
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

# High Voltage -> Static Pages
gem "high_voltage"

# Slim Views -> Templating shortened
gem "slim-rails"

# Letter Opener in Development -> Preview emails without actually sending them
gem "letter_opener", :group => :development

# Quiet Assets in development, keep log clean
gem 'quiet_assets', :group => :development

# Rails Footnotes
gem 'rails-footnotes', '>= 3.7.5.rc4', :group => :development

# Friendly Id
gem 'friendly_id'

# Github Api Wrapper
gem 'github_api'

# jQuery Rails
gem 'jquery-rails'

# Acts as Taggable On
gem 'acts-as-taggable-on'

# Excon - HTTP Client Lib
gem 'excon'

# Awesome Print in console in development
# gem 'awesome_print', :group => :development

# Bourbon Sass
gem 'bourbon'

# Pry
gem 'pry-rails', :group => :development
gem 'pry-remote', :group => :development

# Sorcery
gem 'sorcery', '~> 0.7.12'

# Redcarpet Markdown Parser (used by Github)
gem 'redcarpet'

# Zurb Foundation
 gem 'zurb-foundation', '>= 3.0.0'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'