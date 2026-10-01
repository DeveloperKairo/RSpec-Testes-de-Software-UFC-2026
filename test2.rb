require_relative 'config/environment'

app = Rails.application
env = Rack::MockRequest.env_for("/")

# Mock a session
env['rack.session'] = { user_id: 1 }

status, headers, body = app.call(env)

if status == 500
  puts body
end
