*** Settings ***
Documentation     Documentacao da API:  Authors
Resource          ResourceAuthors.robot
Suite Setup       Acess API Test


*** Test Case ***

Scenario 1 : Scenario 1: Request all authors that have the same IdBook (GET (ID))
        Given I do a requirement to return books whose author has IDBook "10"
        When the status code is checked  200
        And check if the reason is  OK
        Then check if a request returned a list with the indicateds books

Scenario 2: Request from All Available Authors (GET)
        Given I do a requirement to return a list with all authors
        When the status code is checked  200
        And check if the reason is  OK
        Then the request returns a list of all available authors

Scenario 3: Requirement to Register a New Author (POST)
        Given I do a requirement to register a new author
        When the status code is checked  200
        And check if the reason is  OK
        Then check if the author was registered with the data correctly

Scenario 4:Requirement to delete a specific author's resume (DELETE)
        Given I request the deletion of the author "20"
        When the status code is checked  200
        And check if the reason is  OK
        Then check if the respose body returned empty

Scenario 5: Request a specific author (GET(ID))
      Given that I make a request to return the author data "100"
      When the status code is checked  200
      And check if the reason is  OK
      Then check if the request returned the data correctly from the author


Scenario 6: Requirement to update or modify specific author data (PUT)
      Given I do request change in author "100"
      When the status code is checked  200
      And check if the reason is  OK
      Then I check if the author record has been modified correctly
