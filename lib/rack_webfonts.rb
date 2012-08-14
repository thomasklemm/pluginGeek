module Rack
  class Webfonts
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers &&= headers.merge({'Access-Control-Allow-Origin' => '*', 'Access-Control-Allow-Headers' => '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token', 'Access-Control-Allow-Methods' => 'POST, GET, OPTIONS', 'Access-Control-Max-Age' => '2592000'})
      [status, headers, response]
    end
  end
end