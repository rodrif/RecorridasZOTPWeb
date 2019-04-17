Feature: Login Existent user
  Check when a successful login is made

  Scenario: Login existent user
    Given I am on the login page
    When I login with an existent user
    Then I get access to the Home Page
    