*** Settings ***
Resource               ../resources/common.resource
Suite Setup            OpenBrowser                 about:blank    chrome
Suite Teardown         CloseAllBrowsers

*** Test Cases ***
Sample
    [Documentation]
    [Tags]

    ${msg}=            GetLastTwilioMessage
    Should Be Equal    ${msg}  123456
    # use the OTP in next steps of test. 

