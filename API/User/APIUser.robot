*** Settings ***
Documentation     Documentacao da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index#/Users
Resource          ResourceUser.robot
Suite Setup       Acess API Test

*** Test Case ***

Scenario 1: Request to list all users (GET)
    Given I do a request to list all the users
    When checking status code   200
    And Check reason   OK
    Then verifies that the request returns a list of "10" users

Scenario 2: Registration of new user (POST)
    Given I do the registration request from a new user
    When checking status code   200
    And Check reason   OK
    Then check if the user is with all registered data

Scenario 3: Delete a user (DELETE)
    Given I delete the user "10"
    When checking status code  200
    And Check reason   OK
    Then check if the response body is empty

Scenario 4 : Request a specific user (GET[ID])
    Given I do a request to return the user "5"
    When checking status code   200
    And Check reason   OK
    Then check if the request returns all data correctly

Scenario 5: Update or modify user data (PUT)
    Given I request user data change "1"
    When checking status code   200
    And Check reason   OK
    Then check if user has been modified correctly
