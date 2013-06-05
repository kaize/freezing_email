Feature: Web face
  Background:
    Given I successfully run `bundle exec rails new testapp --skip-bundle --skip-sprockets --skip-javascript`
    And I cd to "testapp"
    And I add "freezing_email" from this project as a dependency
    And I successfully run `bundle install`
    And I have allready freezed emails in 'freezed_emails' folder

  @disable-bundler
  Scenario: Integrate FreezingEmail web face to Rails
    When I write to "config/routes.rb" with:
      """
      Testapp::Application.routes.draw do
        mount FreezingEmail::Web, at: "/freezed_emails", as: :freezing_email
      end
      """
    When I successfully run `bundle exec rake routes`
    Then the output should contain "/freezed_emails"
