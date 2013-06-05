Feature: Web face
  Background:
    Given I successfully run `bundle exec rails new testapp --skip-bundle --skip-sprockets --skip-javascript`
    And I cd to "testapp"
    And I add "freezing_email" from this project as a dependency
    And I successfully run `bundle install`
    And I have allready freezed emails in 'freezed_emails' folder

  @disable-bundler
  Scenario: Using Valle automatically sets validations
    When I write to "config/routes.rb" with:
      """
      Testapp::Application.routes.draw do
        mount FreezingEmail::Web, at: "/freezed_emails", as: :freezing_email
      end
      """
    When I successfully run `bundle exec rails s`
    Then the output should contain "2 examples, 0 failures, 1 pending"
    Then a file named "freezed_emails/password_resets" should exist
