web: bundle exec puma -p $PORT -e $RACK_ENV -C config/puma.rb
worker: bundle exec sidekiq -e $RACK_ENV -C config/sidekiq.yml
