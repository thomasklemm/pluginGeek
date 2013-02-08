# Minimal Heroku unicorn config
# * I found no real gain from enabling preload_app on Heroku (which makes for faster worker starts/restarts),
#   and it will cause strange issues if you don't re-establish all connections correctly
# * Heroku has a 30s timeout so we set to 60, allowing them to handle timeouts and issue an H12 error
# * Depending on your memory usage workers can be bumped to 3-4. With Sinatra it can be 8+
worker_processes 3
timeout 60

# Source: This gist: https://gist.github.com/jamiew/2636487
