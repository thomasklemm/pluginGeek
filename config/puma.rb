require "active_record"
cwd = File.dirname(__FILE__)+"/.."
ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || YAML.load_file("#{cwd}/config/database.yml")[ENV["RACK_ENV"]])
ActiveRecord::Base.verify_active_connections!

# Source: http://www.subelsky.com/2012/10/setting-up-puma-rails-on-heroku.html
