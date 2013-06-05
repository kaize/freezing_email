require 'spec_helper'

#set :environment, :test

describe 'FreezingEmail::Web The Web Fase' do
  include Rack::Test::Methods

  def app
    FreezingEmail::Web
  end

  it "shows index of emails" do
    FreezingEmail::Config[:store_path] = File.expand_path('../../../fixtures/', __FILE__)

    get '/'
    last_response.should be_ok
    last_response.body.should match 'Password reset'
  end
end
