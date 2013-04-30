# Increase the ActiveRecord Connection Pool Size
# Set `heroku config:set DB_POOL=20` for starter tier databases

Rails.application.config.after_initialize do
  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    config['pool']              = ENV['DB_POOL'] || 5 # connection pool size
    ActiveRecord::Base.establish_connection(config)
  end
end

# Source: https://devcenter.heroku.com/articles/concurrency-and-database-connections
