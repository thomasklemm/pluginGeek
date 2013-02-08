web: bundle exec puma -p $PORT -e $RACK_ENV -t 1:5
worker: bundle exec sidekiq -e $RACK_ENV -C config/sidekiq.yml
