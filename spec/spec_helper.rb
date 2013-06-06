require 'bundler/setup'
Bundler.require

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require 'rack/test'

RSpec.configure do |config|
  include Rack::Test::Methods
end
