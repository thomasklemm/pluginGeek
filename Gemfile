source 'https://rubygems.org'

# Web server
# [CHECK] Is this the right order in which to load things?
gem 'thin'

# Rails
gem 'rails', '3.2.3'

# Postgres DB
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# High Voltage -> Static Pages
gem "high_voltage"

# Slim Views -> Templating shortened
gem "slim-rails"

# Letter Opener in Development -> Preview emails without actually sending them
gem "letter_opener", :group => :development

# Quiet Assets in development, keep log clean
gem 'quiet_assets', :group => :development

# Curb
gem 'curb'

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