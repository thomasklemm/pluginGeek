# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
# Middleware to gzip responses
use Rack::Deflater
run Knight::Application
