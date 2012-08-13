class AccessControlHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    # Read
    status, headers, response = @app.call(env)
    # Add access control headers
    headers &&= headers.merge({'Access-Control-Allow-Origin' => '*', 'Access-Control-Allow-Headers' => '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token', 'Access-Control-Allow-Methods' => 'POST, GET, OPTIONS', 'Access-Control-Max-Age' => '86400'})
    # Remove headers I don't want to be cached by Cloudfront
    headers.delete('X-Rack-Cache')
    # Return
    [status, headers, response]
  end
end