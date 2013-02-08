require "active_record"
cwd = File.dirname(__FILE__)+"/.."
ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished

database_url = ENV['DATABASE_URL']
if(database_url)
  ENV['DATABASE_URL'] = "#{database_url}?pool=10"
  ActiveRecord::Base.establish_connection
end

ActiveRecord::Base.establish_connection
ActiveRecord::Base.verify_active_connections!

# Source: This gist: https://gist.github.com/subelsky/3987140
# AR Connection Pool: Sidekiq Advanced Options Wiki: https://github.com/mperham/sidekiq/wiki/Advanced-Options
