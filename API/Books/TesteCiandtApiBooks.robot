*** Settings ***
Documentation     Documentacao da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index#/Books
Resource          ResourceBooks.robot
Suite Setup       Acess API Test

*** Test Case ***

Scenario 1: Request to list all books (GET)
    Given that I make a request to list all the books
    When checking status code   200
    And Check reason   OK
    Then verifies that the request returns a list of "200" books

Scenario 2: Registration of new book (POST)
    Given that is made the registration request from a new book
    When checking status code   200
    And Check reason   OK
    Then check if the book is with all registered data

Scenario 3: Delete a Book (DELETE)
    Given that I delete the book "100"
    When checking status code  200
    And Check reason   OK
    Then check if the response body is empty

Scenario 4 : Request a specific book (GET[ID])
    Given that I make a request to return the book "100"
    When checking status code   200
    And Check reason   OK
    Then check if the request returns all data correctly
    
Scenario 5: Update or modify book data (PUT)
    Given that I only changed the book "1"
    When checking status code   200
    And Check reason   OK
    Then check if the book has been modified correctly
