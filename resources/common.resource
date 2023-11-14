*** Settings ***
Library                         RequestsLibrary
Library                         QForce
Library                         String
Library                         Collections

*** Variables ***
${twilio_msgs_url}             https://api.twilio.com/2010-04-01/Accounts/${account_sid}/Messages.json?PageSize=1
${twilio_account_sid}          AC..............................
${twilio_token}                ba..............................

*** Keywords ***
Get Last Twilio Message
    [Documentation]
    # base64 encode basic auth and set headers
    ${headers}=     Create Dictionary
    ${userpass}=    Convert To Bytes    ${twilio_account_sid}:${twilio_token}
    ${userpass}=    Evaluate    base64.b64encode($userpass)    base64
    Set To Dictionary    ${headers}    Authorization    Basic ${userpass}
    Set To Dictionary    ${headers}    Accept           application/json

    # send GET request - this example will return latest 2 messages.
    ${response}=                GET    url=https://api.twilio.com/2010-04-01/Accounts/${twilio_account_sid}/Messages.json?PageSize=2         headers=${headers}
    Should Be Equal As Strings  ${response.status_code}  200

    # get messages list from response
    ${msg}=                     Get From Dictionary  ${response.json()}  messages
    # get wanted body content from second message
    ${body}=                    Get From Dictionary  ${msg[1]}  body
    [Return]                    ${body}

