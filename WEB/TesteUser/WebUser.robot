*** Settings ***

Resource          ResourceUser.robot
Test Setup       Open the page
Test Teardown      Close the page


*** Test Case ***

Scenario 1: Registering new users with all required elements completed
    Given I'm on the login page
    When I write the email to register and click the button to create an account
    And I fill all required inputs
    And click on register I'm redirected to My Account page
    Then the name of the new user appears in the upper right account of the page


Scenario 2: Log Out of Account
    Given I'm on the registered account page
    When I log out
    Then I am redirected to the login page
    And the username of the counter does not appear on screen


Scenario 3: Register with an email already registered
    Given I'm on the login page
    When I try to register an email already registered
    Then I see the error message and cannot complete registration
