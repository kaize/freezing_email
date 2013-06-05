require 'rails'
require 'rack'

module FreezingEmail
  class Engine < Rails::Engine
    config.app_middleware.insert_before(Rack::Runtime, FreezingEmail::Middleware)
  end
end
