*** Settings ***
Library          SeleniumLibrary

*** Variable ***
${URL}              http://automationpractice.com
${BROWSER}          chrome
${EMAIL}            a@c.b

*** Keywords ***

Open the page
    Open BROWSER                        ${URL}      ${BROWSER}
    Click Element                       class=login
    Wait Until Element Is Visible       css=#center_column > h1
    Title Should Be                     Login - My Store
    Input Text                          id=email_create         ${EMAIL} 
    Click Element                       id=SubmitCreate

Close the page
    Close BROWSER

Given I'm on the login page
    Title Should Be                     Login - My Store

When I type all required elements
    Wait Until Element Is Visible       id=customer_firstname
    Input Text                          id=customer_firstname    Ana
    Wait Until Element Is Visible       id=customer_lastname
    Input Text                          id=customer_lastname    Paula
    Wait Until Element Is Visible       id=passwd
    Input Text                          id=passwd             12345
    Wait Until Element Is Visible       id=address1
    Input Text                          id=address1             rua zero
    Wait Until Element Is Visible       id=city
    Input Text                          id=city                 bh
    Select From List By Index           id=id_state       1      
    Wait Until Element Is Visible       id=postcode
    Input Text                          id=postcode             23456
    Wait Until Element Is Visible       id=phone_mobile
    Input Text                          id=phone_mobile           9999999

And click on register I'm redirected to My Account page
    Click Element    xpath=//*[@id="submitAccount"]/span

Then the name of the new user appears in the upper right account of the page
    Title Should Be                     My account - My Store
    Wait Until Element Is Visible       xpath=//*[@id="header"]/div[2]/div/div/nav/div[2]/a


    

