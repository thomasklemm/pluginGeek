class AccessControlHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    [status, headers.merge({'Access-Control-Allow-Origin' => '*'}), response]
  end
end
# Source: http://blog.fallingmanstudios.net/post/14281163243/firefox-font-face-in-rails-with-asset-subdomains