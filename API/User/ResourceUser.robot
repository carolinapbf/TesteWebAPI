*** Settings ***
Documentation     Documentation API:  https://fakerestapi.azurewebsites.net/swagger/ui/index#/Books
Library           ExtendedRequestsLibrary
Library           Collections


*** Variable ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/

*** Keywords ***

##Setup and Teardown
Acess API Test
    Create Session      apiTeste        ${URL_API}

##Actions
Given that I make a request to list all the users
    ${RESPONSE}        Get Request     apiTeste    Users
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that is made the registration request from a new user
    ${HEADERS}          Create Dictionary         content-type=application/json  
    ${RESPONSE}         Post Request     apiTeste    Users
    ...                                 data={"ID": 11,"UserName": "user","Password": "senha"}

    ...                                 headers=${HEADERS}
    Log                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that I delete the user "${ENDPOINT_ID}"
    
    ${RESPONSE}        Delete Request     apiTeste    Users/${ENDPOINT_ID}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}



Given that I make a request to return the user "${ENDPOINT_DELETE}"
    ${RESPONSE}        Get Request     apiTeste    Users/${ENDPOINT_DELETE}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that I only changed the user "${ENDPOINT_PUT}" 
    ${HEADERS}         Create Dictionary         content-type=application/json  
    ${RESPONSE}        Post Request               apiTeste                          Users/${ENDPOINT_PUT}
    ...                                           data={"ID": 1,"UserName": "user","Password": "senha"}
    ...                                           headers=${HEADERS}
    Log                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#### Conferences 
When checking status code  
    [Arguments]     ${STATUSCODE_REQUEST}
    Should Be Equal As Strings  ${RESPONSE.status_code}     ${STATUSCODE_REQUEST}   


And check reason 
    [Arguments]     ${REASON_SOLICITADO}
    Should Be Equal As Strings  ${RESPONSE.reason}     ${REASON_SOLICITADO}

Then check if the response body is empty
    Should Be Empty      ${RESPONSE.content}

Then verifies that the request returns a list of "${NUMBER_OF_ENDPOINT}" users
    Length Should Be    ${RESPONSE.json()}     ${NUMBER_OF_ENDPOINT}

Then check if the request returns all data correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID               5
    Dictionary Should Contain Item      ${RESPONSE.json()}      UserName         User 5
    Dictionary Should Contain Item      ${RESPONSE.json()}      Password         Password5
    

Then check if the user is with all registered data
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID               11
    Dictionary Should Contain Item      ${RESPONSE.json()}      UserName         user
    Dictionary Should Contain Item      ${RESPONSE.json()}      Password         senha

Then check if user has been modified correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID               1
    Dictionary Should Contain Item      ${RESPONSE.json()}      UserName         user
    Dictionary Should Contain Item      ${RESPONSE.json()}      Password         senha

