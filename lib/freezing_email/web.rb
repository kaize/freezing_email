require 'sinatra/base'

require 'freezing_email'

FreezingEmail::Config[:store_path] = File.expand_path('../../../spec/fixtures/', __FILE__)

module FreezingEmail
  class Web < Sinatra::Base
    enable :inline_templates
    enable :reload_templates

    helpers do
      def root_path
        "#{env['SCRIPT_NAME']}/"
      end
    end

    get '/' do
      emails = FreezingEmail::Storage.index
      haml :index, layout: :layout, locals: { emails:  emails }
    end

    get '/:email_name/source'  do
      email = FreezingEmail::Storage.load(params[:email_name])
      email.body.to_s
    end

    get '/:email_name/'  do
      email = FreezingEmail::Storage.load(params[:email_name])
      haml :email, layout: :layout, locals: { email:  email }
    end

    run! if app_file == File.expand_path($0)
  end
end

__END__

@@ layout
%html
  %head
    %title
      FreezingEmail - save emails for latter usage
    %style
      :plain
        body {
          background-image: url(data:image/png;base64,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);
          font-family: helvetica;
        }
        .head a {
          color: #fff;
          text-shadow: 0 6px 15px #bbb;
          text-decoration: none;
        }
        .head a:hover {
          color: eee;
        }
        .head {
          text-align: center;
          font-size: 53px;
          margin-top: 20px;
        }
        .container-big, .container {
          background: #FFF;
          box-shadow: 0px 2px 52px #ccc;
          overflow: auto;
          padding: 10px;
          margin: 20px auto;
          padding: 0;
        }
        .container-big {
          width: 100%
        }
        .container-big iframe {
          width: 100%;
          border: none
        }
        .email-list {
          margin: 0;
          padding: 0;
        }
        .email-list-item {
          border-bottom: 1px solid #ccc;
          padding: 0;
          margin: 0;
        }
        .email-list-item a {
          padding: 10px;
          display: block;
          color: #000;
          text-decoration: none
        }
        .email-list-item a:hover {
          background: #eee;
        }
        .email-head {
          font-weight: bold;
          color: #000
        }
        .email-subject {
        }
        table {
          background: #efefef
        }
        th {
          text-align: left;
        }
  %body
    %h1.head
      %a{href: root_path}
        FreezingEmail's
    = yield

@@ index
.container
  %ul.email-list
    - emails.each do |email|
      %li.email-list-item
        %a{ href: "#{email.name}/" }
          .email-head
            = email.to
          .email-subject
            = email.subject.to_s
@@ email
.email-meta
  %table{ cellpadding: "2px"}
    %tr
      %td
        Subject
      %th
        = email.subject.to_s
    %tr
      %td
        From
      %th
        = email.from
    %tr
      %td
        To
      %th
        = email.to
.container-big
  %iframe{src: "/#{email.name}/source", width:"468", height:"60"}
