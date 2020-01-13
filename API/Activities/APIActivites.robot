*** Settings ***
Documentation     Documentacao da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index#/Books
Resource          ResourceActivities.robot
Suite Setup       Acess API Test

*** Test Case ***


Scenario 1: Request to list all activities (GET)
    Given I do a request to list all the activities
    When checking status code   200
    And Check reason   OK
    Then check if the request returns an activity list "30"


Scenario 2: Registration of new activity (POST)
    Given I do a registration request from a new activity
    When checking status code   200
    And Check reason   OK
    Then check if the activity is with all registered data

Scenario 3: Delete a activity (DELETE)
    Given I delete the activity "10"
    When checking status code  200
    And Check reason   OK
    Then check if the response body is empty

Scenario 4 : Request a specific activity (GET[ID])
    Given I do a request to return the activity "20"
    When checking status code   200
    And Check reason   OK
    Then check if the request returns all data correctly

Scenario 5: Update or modify activity data (PUT)
    Given I only changed the activity "1"
    When checking status code   200
    And Check reason   OK
    Then check if activity has been modified correctly
