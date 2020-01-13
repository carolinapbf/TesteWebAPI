*** Settings ***

Resource         ResourcePesquisa.robot
Test Setup       Open the page
Test Teardown    Close the page


*** Test Case ***

Scenario 1: Search for a product on your site
    Given that I am on the Home page of the site
    When I look for the product "Dress"
    Then the "Dress" product is listed on the result page

Scenario 2: Search for a product that does not exist on the site
    Given that I am on the Home page of the site
    When I look for the product "Pencil"
    Then the page should display the message "No results were found for your search "Pencil""
