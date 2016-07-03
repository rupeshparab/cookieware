class CreateAccessCookie
  def initialize(app)
    @app = app
  end


  def call(env)
    request = Rack::Request.new(env) # no matter how many times you do 'new' you always get the same object
    env["rack.session"]["last_access_t"] = Time.current.utc
    @app.call(env)
  end
end
