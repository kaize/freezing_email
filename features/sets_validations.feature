Feature: sets validations
  Background:
    Given I successfully run `bundle exec rails new testapp --skip-bundle --skip-sprockets --skip-javascript`
    And I cd to "testapp"
    And I add "rspec-rails" as a dependency
    And I add "factory_girl_rails" as a dependency
    And I add "freezing_email" from this project as a dependency
    And I successfully run `bundle install`
    And I successfully run `bundle exec rails g rspec:install`
    And I successfully run `bundle exec rails g controller password_resets new --no-test-framework`
    And I successfully run `bundle exec rails g mailer user_mailer password_reset`
    And I successfully run `bundle exec rails g model user email:string password_hash:string password_salt:string password_reset_token:string password_reset_sent_at:date`
    And I successfully run `bundle exec rake db:migrate RAILS_ENV=test`

  @disable-bundler
  Scenario: Using Valle automatically sets validations
    When I write to "spec/mailers/user_mailer_spec.rb" with:
      """
      require 'spec_helper'

      describe UserMailer do
        describe "password_reset" do
          include FreezingEmail::Rspec 

          let(:user) { FactoryGirl.create(:user, :password_reset_token => "anything") }
          let(:mail) { UserMailer.password_reset }

          it "send user password reset url" do
            mail.subject.should eq("Password reset")
            mail.deliver
          end
        end
      end
      """
    When I successfully run `bundle exec rspec`
    Then the output should contain "2 examples, 0 failures, 1 pending"
    Then a file named "freezed_emails/password_resets" should exist
