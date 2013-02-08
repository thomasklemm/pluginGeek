web: bundle exec puma -p $PORT -e $RACK_ENV -t 6:12
worker: bundle exec sidekiq -e $RACK_ENV -C config/sidekiq.yml
