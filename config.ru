# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
# Use Rack::Cors Middleware
# to set Allow Origin Headers on Fonts (required by Firefox)
use Rack::Cors do
  # Fonts
  allow do
    origins   '*'
    resource  '*', headers: :any, methods: [:get, :post, :options]
  end
end
# Rack::Deflater Middleware
use Rack::Deflater
# Source: http://blog.arvidandersson.se/2011/10/03/how-to-do-the-asset-serving-dance-on-heroku-cedar-with-rails-3-1
run Knight::Application
