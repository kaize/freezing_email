require 'sinatra/base'

require 'freezing_email'

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

    get '/:email_name/view'  do
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
          background: url(data:image/png;base64,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)
        }
        .header-wrapper {
          width: 100%;
          height: 160px;
          float: left;
          clear: both;
          background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAACgCAYAAAAIJ5xTAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDpGNzdGMTE3NDA3MjA2ODExQTg2OUEzMjZFRDRENTNBRCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDoyMDNGRUM4MDYyMDMxMUUwQkIwN0YxNDMzRjIzRkEzOSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDoyMDNGRUM3RjYyMDMxMUUwQkIwN0YxNDMzRjIzRkEzOSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjA1ODAxMTc0MDcyMDY4MTFBNjY3QUEwQTQ0NkUyQTY2IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkY3N0YxMTc0MDcyMDY4MTFBODY5QTMyNkVENEQ1M0FEIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+3i8uWwAAASNJREFUeNrs281KxDAUhuGJ3RSbhSjOzhtwaToK7XX1Anstrl1Ii3Qj8ZySinQmSR2cle+BjxDaPBzSn12M9353ibraXaiAgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgf8nbIyxXdftczeO4zgnV2qpqR0Xfd/fy1j9QaNVsAqdXEse27atvfeVHuM4lWEY5sSu61o11ArmvM+3kqemaQ4xPANXulaNYH0/O239TuJieAJeUBeMYr0/STwCZ9EsfgLejCbxFWx/i8Zw+wO2B6lz0CO8rutnQfca59zLFtRswG8kD2VZKuSnaXqT8VXyLvk8F15wfeHt8nVLPlLoVnj9w/IhyTKcxAI+qi8BBgDMnwnTi//sKgAAAABJRU5ErkJggg==) center top repeat-x;
        }
        .header {
          width: 880px;
          height: 160px;
          margin: 0 auto;
          position: relative;
          text-align: center;
        }
        .header a, .header a:visited {
          display: inline-block;
          position: relative;
          color: #fff;
          text-shadow: 1px 1px 2px black, 0 0 11em;
          text-decoration: none;
        }
        .header h1 {
          font-size: 52px;
          position: relative;
          color: #fff;
        }
        .main-wrapper {
          width: 100%;
          height: 160px;
          float: left;
          clear: both;
        }
        .container, .email-meta {
          font-family: helvetica;
          -webkit-border-radius: 5px;
          border-radius: 5px;
          -webkit-box-shadow: inset 1px 1px 3px 1px rgba(0, 0, 0, 0.5);
          box-shadow: inset 1px 1px 3px 1px rgba(0, 0, 0, 0.5);
          width: 820px;
          margin: 20px auto;
          padding: 5px
        }
        .container-big {
          margin: 30px auto;
          min-height: 20px;
          background: #FFF;
          width: 100%
        }
        .email-list {
          font-family: helvetica;
          margin: 0;
          padding: 0;
        }
        .email-list-item {
          border-bottom: 1px solid rgb(57, 49, 45);
          padding: 0;
          margin: 0;
          list-style: none;
        }
        .email-list-item a {
          padding: 10px;
          display: block;
          color: #fff;
          text-decoration: none
        }
        .email-list-item a:hover {
          background: rgb(57, 49, 45);
        }
        .email-meta {
          width: 500px;
          margin: 10px auto;
          color :#fff;
        }
        .email-meta th {
          text-align: left;
        }
        .email-meta th, .email-meta td {
          color :#fff;
          font-family: helvetica;
          margin: 1px;
          padding: 2px 4px;
        }
  %body
    .header-wrapper
      %header.header
        %a.logo{ href: root_path }
          %h1
            FreezingEmail's
    .main-wrapper
      = yield

@@ index
.container
  %ul.email-list
    - emails.each do |email|
      %li.email-list-item
        %a{ href: "#{root_path}#{email.name}/view" }
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
  != email.body.to_s
