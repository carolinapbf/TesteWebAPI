*** Settings ***

Resource          ResourceUser.robot
Suite Setup       Open the page
#Suite Teardown    Close the page


*** Test Case ***

Scenario 1: Registering new users with all required elements completed
    Given I'm on the login page
    When I type all required elements
    And click on register I'm redirected to My Account page
    Then the name of the new user appears in the upper right account of the page




