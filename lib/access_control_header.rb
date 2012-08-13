class AccessControlHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    headers &&= headers.merge({'Access-Control-Allow-Origin' => 'knight.io', 'Access-Control-Allow-Headers' => '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token', 'Access-Control-Allow-Methods' => 'POST, GET, OPTIONS', 'Access-Control-Max-Age' => '86400'})
    [status, headers, response]
  end
end