*** Settings ***
Documentation     Documentacao da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index#/Books
Resource          ResourceUser.robot
Suite Setup       Acess API Test

*** Test Case ***

Scenario 1: Request to list all users (GET)
    Given that I make a request to list all the users
    When checking status code   200
    And Check reason   OK
    Then verifies that the request returns a list of "10" users

Scenario 2: Registration of new user (POST)
    Given that is made the registration request from a new user
    When checking status code   200
    And Check reason   OK
    Then check if the user is with all registered data

Scenario 3: Delete a user (DELETE)
    Given that I delete the user "10"
    When checking status code  200
    And Check reason   OK
    Then check if the response body is empty

Scenario 4 : Request a specific user (GET[ID])
    Given that I make a request to return the user "5"
    When checking status code   200
    And Check reason   OK
    Then check if the request returns all data correctly
    
Scenario 5: Update or modify user data (PUT)
    Given that I only changed the user "1"
    When checking status code   200
    And Check reason   OK
    Then check if user has been modified correctly