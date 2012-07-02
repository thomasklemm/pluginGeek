# Config for Unicorn app server

# Loads Rails and App to enable super fast worker spawn times
#  via https://github.com/blog/517-unicorn
#  nescessary when using New Relic according to http://blog.railsonfire.com/2012/05/06/Unicorn-on-Heroku.html
preload_app true

# Amout of unicorn workers to spin up
#  take a look at your memory usage via New Relic
worker_processes 3

# Restarts workers that hang for 30 seconds
timeout 30

# Avoiding SSL Errors
#  via http://kuon.goyman.com/2012/heroku_unicorn/
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end