require 'sinatra/base'

require 'freezing_email'

module FreezingEmail
  class Web < Sinatra::Base
    enable :inline_templates

    get('/') do
      emails = FreezingEmail::Storage.index
      haml :index, layout: :layout, locals: { emails:  emails }
    end

    run! if app_file == File.expand_path($0)
  end
end

__END__

@@ layout
%html
  = yield

@@ index
%div.title Hello world.
- emails.each do |email|
  = email.subject.to_s
