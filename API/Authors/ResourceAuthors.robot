*** Settings ***
Documentation     Documentacao da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index#/Authors
Library           ExtendedRequestsLibrary
Library           Collections


*** Variable ***
${URL_API}                https://fakerestapi.azurewebsites.net/


*** Keywords ***

#_________Setup and Teardown______________
Acess API Test
    Create Session      apiTeste                 ${URL_API}

# ________________________________Actions___________________________
#(GET)
Given I do a requirement to return a list with all authors
    ${RESPONSE}        Get Request     apiTeste    api/Authors
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#(GET(ID)) - Author
Given that I make a request to return the author data "${ENDPOINT_ID}"
    ${RESPONSE}        Get Request     apiTeste    api/Authors/${ENDPOINT_ID}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#(GET(ID)) - IdBook
Given I do a requirement to return books whose author has IDBook "${ENDPOINT_IDBook}"
    ${RESPONSE}        Get Request     apiTeste    authors/books/${ENDPOINT_IDBook}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#(POST)
Given I do a requirement to register a new author
    ${HEADERS}          Create Dictionary             content-type=application/json
    ${RESPONSE}         Post Request      apiTeste    api/Authors
    ...                                               data={"ID": 900,"IDBook": 901,"FirstName": "ANA","LastName": "CAROLINA"}
    ...                                               headers=${HEADERS}
    Log                 ${RESPONSE.text}
    Set Test Variable   ${RESPONSE}
#(DELETE)
Given I request the deletion of the author "${ENDPOINT_ID}"
    ${RESPONSE}         Delete Request    apiTeste    api/Authors/${ENDPOINT_ID}
    LOG                 ${RESPONSE.text}
    Set Test Variable   ${RESPONSE}

#(PUT)
Given I do request change in author "${ENDPOINT_PUT}"
    ${HEADERS}         Create Dictionary          content-type=application/json
    ${RESPONSE}        Post Request               apiTeste                          api/Authors/${ENDPOINT_PUT}
    ...                                           data={"ID": 204,"IDBook": 204,"FirstName": "ANA","LastName": "CAROLINA"}
    ...                                           headers=${HEADERS}
    Log                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

# __________________________ CONFIRMATIONS______________________
# COMMON STEPS
When the status code is checked
    [Arguments]       ${STATUSCODE_REQUEST}
    Should Be Equal As Strings  ${RESPONSE.status_code}     ${STATUSCODE_REQUEST}

And check if the reason is
    [Arguments]     ${REASON_SOLICITADO}
    Should Be Equal As Strings  ${RESPONSE.reason}          ${REASON_SOLICITADO}

#GET(ID_BOOKS)
Then check if a request returned a list with the indicateds books
    ${SIZE}   Get Length    ${RESPONSE.json()}
    Log List               ${RESPONSE.json()}
    :FOR    ${COUNT}    IN RANGE    0    ${SIZE}
    \    ${DIC}        Get From List          ${RESPONSE.json()}    ${COUNT}
    \    Dictionary Should Contain Item      ${DIC}      IDBook             10
    \    Run Keyword If    ${COUNT} == ${SIZE}   Log    LOOP CLOSED

#(GET)
Then the request returns a list of all available authors
    ${AMOUNT_OF_AUTHORS}   Get Length    ${RESPONSE.json()}
    List Should Not Contain Duplicates    ${RESPONSE.json()}
    Log    ${AMOUNT_OF_AUTHORS} author records returned, no records repeated


#(POST)
Then check if the author was registered with the data correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              900
    Dictionary Should Contain Item      ${RESPONSE.json()}      IDBook          901
    Dictionary Should Contain Item      ${RESPONSE.json()}      FirstName       ANA
    Dictionary Should Contain Item      ${RESPONSE.json()}      LastName        CAROLINA

#(DELETE)
Then check if the respose body returned empty
    Should Be Empty     ${RESPONSE.content}

#GET(ID_AUTHORS)
Then check if the request returned the data correctly from the author
    Convert To String    ${RESPONSE.json()['IDBook']}
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              100
    Dictionary Should Contain Key    ${RESPONSE.json()}    IDBook
    Dictionary Should Contain Item      ${RESPONSE.json()}      FirstName       First Name 100
    Dictionary Should Contain Item      ${RESPONSE.json()}      LastName        Last Name 100

#(PUT)
Then I check if the author record has been modified correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              204
    Dictionary Should Contain Item      ${RESPONSE.json()}      IDBook          204
    Dictionary Should Contain Item      ${RESPONSE.json()}      FirstName       ANA
    Dictionary Should Contain Item      ${RESPONSE.json()}      LastName        CAROLINA
