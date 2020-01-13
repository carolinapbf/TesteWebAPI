*** Settings ***
Documentation     Documentacao da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index#/CoverPhotos
Library           ExtendedRequestsLibrary
Library           Collections


*** Variable ***
${URL_API}                https://fakerestapi.azurewebsites.net/

*** Keywords ***

##_________Setup and Teardown______________

Acess API Test
    Create Session      apiTeste                 ${URL_API}


##________________________________Actions___________________________

#(GET)
Given I do a request to return the cover photos
    ${RESPONSE}        Get Request     apiTeste    api/CoverPhotos
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#(GET(ID)) -
Given I request the return of the cover photo "${ENDPOINT_ID}"
    ${RESPONSE}        Get Request     apiTeste    api/CoverPhotos/${ENDPOINT_ID}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#(GET(ID)) - IdBook
Given I request all cover photos whose IdBook is "${ENDPOINT_IDBook}"
    ${RESPONSE}        Get Request     apiTeste    books/covers/${ENDPOINT_IDBook}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#(POST)
Given I do request to register one on the cover photo
    ${HEADERS}          Create Dictionary             content-type=application/json
    ${RESPONSE}         Post Request      apiTeste    api/CoverPhotos
    ...                                               data={"ID":250,"IDBook":150,"Url":"https://placeholdit.imgix.net/TESTE"}
    ...                                               headers=${HEADERS}
    Log                 ${RESPONSE.text}
    Set Test Variable   ${RESPONSE}
#(DELETE)
Given the request is made to delete the cover photo "${ENDPOINT_ID}"
    ${RESPONSE}         Delete Request    apiTeste    api/CoverPhotos/${ENDPOINT_ID}
    LOG                 ${RESPONSE.text}
    Set Test Variable   ${RESPONSE}

#(PUT)
Given I do request to change the cover photo data "${ENDPOINT_PUT}"
    ${HEADERS}         Create Dictionary          content-type=application/json
    ${RESPONSE}        Post Request               apiTeste                          api/CoverPhotos/${ENDPOINT_PUT}
    ...                                           data={"ID":550,"IDBook":150,"Url":"https://placeholdit.imgix.net/TESTE"}
    ...                                           headers=${HEADERS}
    Log                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

#### __________________________ CONFIRMATIONS______________________
# COMMON STEPS
When the status code is checked
    [Arguments]       ${STATUSCODE_REQUEST}
    Should Be Equal As Strings  ${RESPONSE.status_code}     ${STATUSCODE_REQUEST}

And check if the reason is
    [Arguments]     ${REASON_SOLICITADO}
    Should Be Equal As Strings  ${RESPONSE.reason}          ${REASON_SOLICITADO}

#GET(ID_BOOKS)
Then check if a request returned a list with the indicated book
    ${SIZE}   Get Length    ${RESPONSE.json()}
    Log List               ${RESPONSE.json()}
    :FOR    ${COUNT}    IN RANGE    0    ${SIZE}
    \    ${DIC}        Get From List          ${RESPONSE.json()}    ${COUNT}
    \    Dictionary Should Contain Item      ${DIC}      IDBook             50
    \    Run Keyword If    ${COUNT} == ${SIZE}   Log    LOOP CLOSED

#(GET)
Then the request returns me how many cover photos are available.
    ${AMOUNT_OF_COVER}      Get Length    ${RESPONSE.json()}
    List Should Not Contain Duplicates    ${RESPONSE.json()}
    Log                     ${AMOUNT_OF_COVER}cover photo records returned, no record repeated

#(POST)
Then check if the cover photo was registered correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              250
    Dictionary Should Contain Item      ${RESPONSE.json()}      IDBook          150
    Dictionary Should Contain Item      ${RESPONSE.json()}      Url             https://placeholdit.imgix.net/TESTE

#(DELETE)
Then check if the respose body returned empty
    Should Be Empty     ${RESPONSE.content}

#GET(ID_AUTHORS)
Then check if the request returned the cover photo data correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              40
    Dictionary Should Contain Item      ${RESPONSE.json()}      IDBook          40
    Dictionary Should Contain Item      ${RESPONSE.json()}      Url             https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 40&w=250&h=350

#(PUT)
Then I check if the author record has been modified correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              550
    Dictionary Should Contain Item      ${RESPONSE.json()}      IDBook          150
    Dictionary Should Contain Item      ${RESPONSE.json()}      Url             https://placeholdit.imgix.net/TESTE
