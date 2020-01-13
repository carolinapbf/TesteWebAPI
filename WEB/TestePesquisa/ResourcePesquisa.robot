*** Settings ***
Library          SeleniumLibrary

*** Variable ***
${URL}              http://automationpractice.com
${BROWSER}          chrome

*** Keywords ***

Open the page
    Open BROWSER    ${URL}      ${BROWSER}

Close the page
    Close BROWSER
#___________COMMON STEPS ____________________
Given that I am on the Home page of the site
    Title Should Be     My Store

When I look for the product "${PRODUCT}"
    Input Text         id=search_query_top     ${PRODUCT}
    Click Element      name=submit_search

Then the "${PRODUCT_NAME}" product is listed on the result page
    Wait Until Element Is Visible      css=.navigation_page
    Title Should Be                    Search - My Store
    Page Should Contain Link           xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUCT_NAME}")]

Then the page should display the message "${MENSSAGE}"
    Wait Until Element Is Visible       xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]
    Title Should Be                     Search - My Store
    Element Text Should Be              //*[@id="center_column"]/p[@class="alert alert-warning"]        ${MENSSAGE}
