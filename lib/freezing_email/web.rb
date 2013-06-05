require 'sinatra/base'
require 'slim'

require 'freezing_email'

module FreezingEmail
  class Web < Sinatra::Base
    get('/freezing_email') do
      echo '123'
    end
  end
end
