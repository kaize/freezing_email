require 'bundler/setup'
Bundler.require

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

RSpec.configure do |config|
  include Rack::Test::Methods
end
