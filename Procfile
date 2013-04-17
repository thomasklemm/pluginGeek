web: bundle exec puma -p $PORT -e $RACK_ENV -t 1:20 -C config/puma.rb
worker: bundle exec sidekiq -e $RACK_ENV -C config/sidekiq.yml
