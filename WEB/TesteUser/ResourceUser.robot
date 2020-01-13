*** Settings ***
Library          SeleniumLibrary
Library          String
Library          BuiltIn

*** Variable ***
${URL}              http://automationpractice.com
${BROWSER}          chrome
${ERROR_MSG}      An account using this email address has
        ...       already been registered. Please enter a
        ...       valid password or request a new one.


*** Keywords ***


Open the page
    Open BROWSER            ${URL}                   ${BROWSER}
    ${identificador}=       Generate Random String   6   [LETTERS]
    ${EMAIL}                Set Variable             ${identificador}@TEST.COM
    Set Global Variable     ${EMAIL}
    Log     ${EMAIL}


Close the page
    Close BROWSER


#_________________Common Steps ____________________

Given I'm on the login page
    Click Element                       class=login
    Wait Until Element Is Visible       css=#center_column > h1
    Title Should Be                     Login - My Store
#_________________Scenario 1 ____________________


When I write the email to register and click the button to create an account
    Input Text                          id=email_create         ${EMAIL}
    Click Element                       id=SubmitCreate

And I fill all required inputs

    Wait Until Element Is Visible       id=customer_firstname
    Input Text                          id=customer_firstname     Ana
    Wait Until Element Is Visible       id=customer_lastname
    Input Text                          id=customer_lastname      Paula
    Wait Until Element Is Visible       id=passwd
    Input Text                          id=passwd                 12345
    Wait Until Element Is Visible       id=address1
    Input Text                          id=address1               rua zero
    Wait Until Element Is Visible       id=city
    Input Text                          id=city                   bh
    Select From List By Index           id=id_state               1
    Wait Until Element Is Visible       id=postcode
    Input Text                          id=postcode               23456
    Wait Until Element Is Visible       id=phone_mobile
    Input Text                          id=phone_mobile           9999999

And click on register I'm redirected to My Account page
    Click Element    xpath=//*[@id="submitAccount"]/span

Then the name of the new user appears in the upper right account of the page
    Title Should Be                     My account - My Store
    Wait Until Element Is Visible       xpath=//*[@id="header"]/div[2]/div/div/nav/div[2]/a
    Current Frame Should Contain        Ana Paula

#_________________Scenario 2_____________

Given I'm on the registered account page
    Click Element                       class=login
    Wait Until Element Is Visible       css=#center_column > h1
    Title Should Be                     Login - My Store
    Input Text                          id=email                  a@c.p
    Input Password                      id=passwd                 12345
    Click Button                        id=SubmitLogin

When I log out
    Click Element    class=logout

Then I am redirected to the login page
    Wait Until Element Is Visible       css=#center_column > h1
    Title Should Be                     Login - My Store

And the username of the counter does not appear on screen
    Current Frame Should Not Contain    Ana Paula


# ___________________Scenario 3____________


When I try to register an email already registered
    Input Text                          id=email_create         a@c.p
    Click Element                       id=SubmitCreate

Then I see the error message and cannot complete registration
    Wait Until Element Is Visible    css=#create_account_error
    Page Should Contain Element      id=create_account_error
