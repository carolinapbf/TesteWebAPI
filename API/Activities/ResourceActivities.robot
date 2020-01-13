*** Settings ***
Documentation     Documentation API:  https://fakerestapi.azurewebsites.net/swagger/ui/index#/
Library           ExtendedRequestsLibrary
Library           Collections


*** Variable ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/

*** Keywords ***

#_________Setup and Teardown______________
Acess API Test
    Create Session      apiTeste        ${URL_API}

# ________________________________Actions___________________________

#(GET)
Given I do a request to list all the activities
    ${RESPONSE}        Get Request     apiTeste    Activities
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}
#(POST)
Given I do a registration request from a new activity
    ${HEADERS}          Create Dictionary            content-type=application/json
    ${RESPONSE}         Post Request     apiTeste    Activities
    ...                                              data={"ID": 31,"Title": "TEST ACTIVITIES","DueDate": "2019-11-10T14:09:00.204Z","Completed": true}

    ...                                  headers=${HEADERS}
    Log                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}
#(DELETE)
Given I delete the activity "${ENDPOINT_ID}"

    ${RESPONSE}        Delete Request     apiTeste    Activities/${ENDPOINT_ID}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}


#(GET(ID))
Given I do a request to return the activity "${ENDPOINT_DELETE}"
    ${RESPONSE}        Get Request     apiTeste    Activities/${ENDPOINT_DELETE}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#(PUT)
Given I only changed the activity "${ENDPOINT_PUT}"
    ${HEADERS}         Create Dictionary          content-type=application/json
    ${RESPONSE}        Post Request               apiTeste                          Activities/${ENDPOINT_PUT}
    ...                                           data={"ID": 21,"Title": "TEST ACTIVITIES","DueDate": "2019-11-10T14:09:00.204Z","Completed": true}
    ...                                           headers=${HEADERS}
    Log                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

# __________________________ CONFIRMATIONS______________________

#COMMON STEPS
When checking status code
    [Arguments]     ${STATUSCODE_REQUEST}
    Should Be Equal As Strings  ${RESPONSE.status_code}     ${STATUSCODE_REQUEST}


And check reason
    [Arguments]     ${REASON_SOLICITADO}
    Should Be Equal As Strings  ${RESPONSE.reason}     ${REASON_SOLICITADO}

#(GET)

Then check if the request returns an activity list "${NUMBER_OF_ENDPOINT}"
    Length Should Be    ${RESPONSE.json()}     ${NUMBER_OF_ENDPOINT}
    List Should Not Contain Duplicates         ${RESPONSE.json()}


#(POST)
Then check if the activity is with all registered data
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              31
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           TEST ACTIVITIES
    Should Not Be Empty      ${RESPONSE.json()["DueDate"]}
    Dictionary Should Contain Item      ${RESPONSE.json()}      Completed       True

#(DELETE)
Then check if the response body is empty
    Should Be Empty      ${RESPONSE.content}



#(GET(ID))
Then check if the request returns all data correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              20
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           Activity 20
    Should Not Be Empty      ${RESPONSE.json()["DueDate"]}
    Dictionary Should Contain Item      ${RESPONSE.json()}      Completed         True


#(PUT)
Then check if activity has been modified correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              21
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           TEST ACTIVITIES
    Should Not Be Empty      ${RESPONSE.json()["DueDate"]}
    Dictionary Should Contain Item      ${RESPONSE.json()}      Completed       True
