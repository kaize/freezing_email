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
  end

  it "shows email" do
    FreezingEmail::Config[:store_path] = File.expand_path('../../../fixtures/', __FILE__)

    get '/password_resets/'
    last_response.should be_ok
  end

  it "shows email" do
    FreezingEmail::Config[:store_path] = File.expand_path('../../../fixtures/', __FILE__)

    get '/password_resets/source'
    last_response.should be_ok
  end
end
