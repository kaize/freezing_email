require 'bundler/setup'
Bundler.require

require 'rack/test'

RSpec.configure do |config|
  include Rack::Test::Methods
end
