*** Settings ***
Documentation     Documentacao da API:  Authors
Resource          ResourceCoverPhotos.robot
Suite Setup       Acess API Test


*** Test Case ***

Scenario 1 : Scenario 1: Request all authors that have the same IdBook (GET (ID))
        Given I request all cover photos whose IdBook is "50"
        When the status code is checked  200
        And check if the reason is  OK
        Then check if a request returned a list with the indicated book

Scenario 2: Request from All Available Authors (GET)
        Given I do a request to return the cover photos
        When the status code is checked  200
        And check if the reason is  OK
        Then the request returns me how many cover photos are available.

Scenario 3: Requirement to Register a New Author (POST)
        Given I do request to register one on the cover photo
        When the status code is checked  200
        And check if the reason is  OK
        Then check if the cover photo was registered correctly

Scenario 4:Requirement to delete a specific author's resume (DELETE)
        Given the request is made to delete the cover photo "100"
        When the status code is checked  200
        And check if the reason is  OK
        Then check if the respose body returned empty

Scenario 5: Request a specific author (GET(ID))
      Given I request the return of the cover photo "40"
      When the status code is checked  200
      And check if the reason is  OK
      Then check if the request returned the cover photo data correctly


Scenario 6: Requirement to update or modify specific author data (PUT)
      Given I do request to change the cover photo data "50"
      When the status code is checked  200
      And check if the reason is  OK
      Then I check if the author record has been modified correctly
