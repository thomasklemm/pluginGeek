web: bundle exec puma -p $PORT -e $RACK_ENV -t 10:30 -C config/puma.rb
worker: bundle exec sidekiq -e $RACK_ENV -C config/sidekiq.yml
