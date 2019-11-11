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
Given that I make a request to list all the books
    ${RESPONSE}        Get Request     apiTeste    Books
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that I make a request to return the book "${ENDPOINT_ID}"
    
    ${RESPONSE}        Get Request     apiTeste    Books/${ENDPOINT_ID}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that is made the registration request from a new book
    ${HEADERS}         Create Dictionary            content-type=application/json  
    ${RESPONSE}        Post Request     apiTeste    Books
    ...                                 data={"ID": 301,"Title": "TESTE","Description": "TESTE","PageCount": 0,"Excerpt": "TESTE","PublishDate": "2019-11-09T15:13:52.158Z"}
    ...                                 headers=${HEADERS}
    Log                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that I delete the book "${ENDPOINT_DELETE}"
    ${RESPONSE}        Delete Request     apiTeste    Books/${ENDPOINT_DELETE}
    LOG                ${RESPONSE.text}
    Set Test Variable  ${RESPONSE}

Given that I only changed the book "${ENDPOINT_PUT}" 
    ${HEADERS}          Create Dictionary         content-type=application/json  
    ${RESPONSE}        Post Request     apiTeste    Books/${ENDPOINT_PUT}
    ...                                 data={"ID": 201,"Title": "TESTE","Description": "TESTE","PageCount": 0,"Excerpt": "TESTE","PublishDate": "2019-11-09T15:13:52.158Z"}
    ...                                 headers=${HEADERS}
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

Then verifies that the request returns a list of "${NUMBER_OF_ENDPOINT}" books
    Length Should Be    ${RESPONSE.json()}     ${NUMBER_OF_ENDPOINT}

Then check if the request returns all data correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              100
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           Book 100
    Dictionary Should Contain Item      ${RESPONSE.json()}      PageCount       10000
    ####Conferindo se os itens para as chaves solicitadas, nao estao vazias. Visto que seu conteudo varia
    Should Not Be Empty      ${RESPONSE.json()["Description"]}          
    Should Not Be Empty      ${RESPONSE.json()["Excerpt"]}      
    Should Not Be Empty      ${RESPONSE.json()["PublishDate"]}

Then check if the book is with all registered data
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              201
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           TESTE
    Dictionary Should Contain Item      ${RESPONSE.json()}      PageCount       0
    Dictionary Should Contain Item      ${RESPONSE.json()}      Description     TESTE
    Dictionary Should Contain Item      ${RESPONSE.json()}      Excerpt         TESTE
    Should Not Be Empty      ${RESPONSE.json()["PublishDate"]}

Then check if the book is with all registered data
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              301
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           TESTE
    Dictionary Should Contain Item      ${RESPONSE.json()}      PageCount       0
    Dictionary Should Contain Item      ${RESPONSE.json()}      Description     TESTE
    Dictionary Should Contain Item      ${RESPONSE.json()}      Excerpt         TESTE
    Should Not Be Empty      ${RESPONSE.json()["PublishDate"]}

Then check if the book has been modified correctly
    Dictionary Should Contain Item      ${RESPONSE.json()}      ID              201
    Dictionary Should Contain Item      ${RESPONSE.json()}      Title           TESTE
    Dictionary Should Contain Item      ${RESPONSE.json()}      PageCount       0
    Dictionary Should Contain Item      ${RESPONSE.json()}      Description     TESTE
    Dictionary Should Contain Item      ${RESPONSE.json()}      Excerpt         TESTE
    Should Not Be Empty      ${RESPONSE.json()["PublishDate"]}



