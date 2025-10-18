*** Settings ***
Documentation    Reusable Robot Framework keywords for authentication module
Library          SeleniumLibrary
Library          BuiltIn
Library          DateTime

*** Variables ***
${BASE_URL}          http://127.0.0.1:8000
${LOGIN_URL}         ${BASE_URL}/stafflogin/
${SIGNUP_URL}        ${BASE_URL}/staffsignup/
${DASHBOARD_URL}     ${BASE_URL}/dashboard/
${HOME_URL}          ${BASE_URL}/
${BROWSER}           Chrome
${TIMEOUT}           10s

# Element Locators
${SIGNUP_USERNAME}   id=id_username
${SIGNUP_EMAIL}      id=id_email
${SIGNUP_PASSWORD1}  id=id_password1
${SIGNUP_PASSWORD2}  id=id_password2
${SIGNUP_BUTTON}     xpath=//button[@type='submit']

${LOGIN_USERNAME}    id=id_username
${LOGIN_PASSWORD}    id=id_password
${LOGIN_BUTTON}      xpath=//button[@type='submit']

${LOGOUT_BUTTON}     xpath=//a[contains(text(),'Logout')]
${DASHBOARD_TITLE}   xpath=//h1[contains(text(),'Dashboard')]

*** Keywords ***
Open Browser To Base URL
    [Documentation]    Opens browser and navigates to the base URL
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Open Login Page
    [Documentation]    Navigate to the login page
    Go To    ${LOGIN_URL}
    Wait Until Page Contains Element    ${LOGIN_USERNAME}    ${TIMEOUT}
    Page Should Contain    Login

Open Signup Page
    [Documentation]    Navigate to the signup page
    Go To    ${SIGNUP_URL}
    Wait Until Page Contains Element    ${SIGNUP_USERNAME}    ${TIMEOUT}
    Page Should Contain    Sign Up

Input Signup Details
    [Documentation]    Fill in signup form with provided details
    [Arguments]    ${username}    ${email}    ${password1}    ${password2}
    Input Text    ${SIGNUP_USERNAME}    ${username}
    Input Text    ${SIGNUP_EMAIL}      ${email}
    Input Text    ${SIGNUP_PASSWORD1}  ${password1}
    Input Text    ${SIGNUP_PASSWORD2}  ${password2}

Click Signup Button
    [Documentation]    Click the signup submit button
    Click Button    ${SIGNUP_BUTTON}
    Sleep    2s    # Wait for page response

Input Login Details
    [Documentation]    Fill in login form with provided credentials
    [Arguments]    ${username}    ${password}
    Input Text    ${LOGIN_USERNAME}    ${username}
    Input Text    ${LOGIN_PASSWORD}    ${password}

Click Login Button
    [Documentation]    Click the login submit button
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s    # Wait for page response

Open Dashboard
    [Documentation]    Navigate to dashboard and verify access
    Go To    ${DASHBOARD_URL}
    Wait Until Page Contains Element    ${DASHBOARD_TITLE}    ${TIMEOUT}
    Page Should Contain    Dashboard

Click Logout Button
    [Documentation]    Click logout button and wait for redirect
    Click Element    ${LOGOUT_BUTTON}
    Sleep    2s    # Wait for logout process

Verify Successful Signup
    [Documentation]    Verify that signup was successful
    # This might redirect to login page or dashboard depending on implementation
    ${current_url}=    Get Location
    Should Not Be Equal    ${current_url}    ${SIGNUP_URL}
    Page Should Not Contain    error

Verify Signup Error
    [Documentation]    Verify that signup failed with error message
    [Arguments]    ${expected_error}
    Page Should Contain    ${expected_error}

Verify Successful Login
    [Documentation]    Verify that login was successful and user is on dashboard
    Wait Until Page Contains Element    ${DASHBOARD_TITLE}    ${TIMEOUT}
    Location Should Be    ${DASHBOARD_URL}
    Page Should Contain    Dashboard

Verify Login Error
    [Documentation]    Verify that login failed with error message
    [Arguments]    ${expected_error}
    Page Should Contain    ${expected_error}
    Location Should Be    ${LOGIN_URL}

Verify Successful Logout
    [Documentation]    Verify that logout was successful and user is redirected
    Location Should Be    ${HOME_URL}
    Page Should Not Contain    Dashboard

Verify Restricted Access After Logout
    [Documentation]    Verify that dashboard is not accessible after logout
    Go To    ${DASHBOARD_URL}
    # Should be redirected to login page or show access denied
    ${current_url}=    Get Location
    Should Not Be Equal    ${current_url}    ${DASHBOARD_URL}

Close Test Browser
    [Documentation]    Close the browser after test completion
    Close Browser

Take Screenshot With Timestamp
    [Documentation]    Take screenshot with timestamp for reporting
    [Arguments]    ${filename}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Capture Page Screenshot    ${filename}_${timestamp}.png