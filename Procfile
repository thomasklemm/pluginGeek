web: bundle exec puma -p $PORT -e $RACK_ENV -C config/puma.rb
worker: bundle exec sidekiq -C config/sidekiq.yml -e $RACK_ENV
