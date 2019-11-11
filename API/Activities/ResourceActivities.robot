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
Given that I make a request to list all the activities
    ${RESPONSE}        Get Request     apiTeste    Activities
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that is made the registration request from a new activity
    ${HEADERS}          Create Dictionary            content-type=application/json  
    ${RESPONSE}         Post Request     apiTeste    Activities
    ...                                              data={"ID": 31,"Title": "TEST ACTIVITIES","DueDate": "2019-11-10T14:09:00.204Z","Completed": true}

    ...                                  headers=${HEADERS}
    Log                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that I delete the activity "${ENDPOINT_ID}"
    
    ${RESPONSE}        Delete Request     apiTeste    Activities/${ENDPOINT_ID}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}



Given that I make a request to return the activity "${ENDPOINT_DELETE}"
    ${RESPONSE}        Get Request     apiTeste    Activities/${ENDPOINT_DELETE}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that I only changed the activity "${ENDPOINT_PUT}" 
    ${HEADERS}         Create Dictionary          content-type=application/json  
    ${RESPONSE}        Post Request               apiTeste                          Activities/${ENDPOINT_PUT}
    ...                                           data={"ID": 21,"Title": "TEST ACTIVITIES","DueDate": "2019-11-10T14:09:00.204Z","Completed": true}
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

Then verifies that the request returns a list of "${NUMBER_OF_ENDPOINT}" activities
    Length Should Be    ${RESPONSE.json()}     ${NUMBER_OF_ENDPOINT}

Then check if the request returns all data correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              20
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           Activity 20
    Should Not Be Empty      ${RESPONSE.json()["DueDate"]}
    Dictionary Should Contain Item      ${RESPONSE.json()}      Completed         True
    ####Conferindo se os itens para as chaves solicitadas, nao estao vazias. Visto que seu conteudo varia


Then check if the activity is with all registered data
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              31
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           TEST ACTIVITIES
    Should Not Be Empty      ${RESPONSE.json()["DueDate"]}
    Dictionary Should Contain Item      ${RESPONSE.json()}      Completed       True

Then check if activity has been modified correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              21
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           TEST ACTIVITIES
    Should Not Be Empty      ${RESPONSE.json()["DueDate"]}
    Dictionary Should Contain Item      ${RESPONSE.json()}      Completed       True



