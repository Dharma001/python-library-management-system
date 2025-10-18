*** Settings ***
Documentation    Robot Framework test cases for Login page using SeleniumLibrary
Resource         Authentication_Resources.robot
Suite Setup      Open Browser To Base URL
Suite Teardown   Close Test Browser
Test Setup       Open Login Page

*** Variables ***
${VALID_USERNAME}      admin
${VALID_PASSWORD}      admin123
${WRONG_PASSWORD}      wrongpassword123
${NONEXISTENT_USER}    nonexistentuser
${EMPTY_USERNAME}      ${EMPTY}
${EMPTY_PASSWORD}      ${EMPTY}

*** Test Cases ***
Login Successful With Valid Credentials
    [Documentation]    Test successful login with valid username and password
    [Tags]    positive    login    critical
    
    # Take screenshot before login attempt
    Take Screenshot With Timestamp    login_page_before_valid
    
    # Input valid login credentials
    Input Login Details    ${VALID_USERNAME}    ${VALID_PASSWORD}
    
    # Take screenshot after filling login form
    Take Screenshot With Timestamp    login_form_filled_valid
    
    # Submit login form
    Click Login Button
    
    # Verify successful login and dashboard access
    Verify Successful Login
    
    # Take screenshot after successful login
    Take Screenshot With Timestamp    login_success_dashboard

Login Fails With Wrong Password
    [Documentation]    Test login failure with correct username but wrong password
    [Tags]    negative    login    authentication
    
    # Take screenshot before login attempt
    Take Screenshot With Timestamp    login_page_before_wrong_password
    
    # Input valid username with wrong password
    Input Login Details    ${VALID_USERNAME}    ${WRONG_PASSWORD}
    
    # Take screenshot after filling login form
    Take Screenshot With Timestamp    login_form_filled_wrong_password
    
    # Submit login form
    Click Login Button
    
    # Verify login error for wrong password
    Verify Login Error    Invalid username or password
    
    # Take screenshot showing login error
    Take Screenshot With Timestamp    login_wrong_password_error

Login Fails For Non-Existent User
    [Documentation]    Test login failure with non-existent username
    [Tags]    negative    login    authentication
    
    # Take screenshot before login attempt
    Take Screenshot With Timestamp    login_page_before_nonexistent_user
    
    # Input non-existent username with any password
    Input Login Details    ${NONEXISTENT_USER}    ${VALID_PASSWORD}
    
    # Take screenshot after filling login form
    Take Screenshot With Timestamp    login_form_filled_nonexistent_user
    
    # Submit login form
    Click Login Button
    
    # Verify login error for non-existent user
    Verify Login Error    Invalid username or password
    
    # Take screenshot showing login error
    Take Screenshot With Timestamp    login_nonexistent_user_error

Login Fails With Empty Username
    [Documentation]    Test login failure when username field is empty
    [Tags]    negative    login    validation
    
    # Take screenshot before login attempt
    Take Screenshot With Timestamp    login_page_before_empty_username
    
    # Input empty username with valid password
    Input Login Details    ${EMPTY_USERNAME}    ${VALID_PASSWORD}
    
    # Take screenshot after filling login form
    Take Screenshot With Timestamp    login_form_filled_empty_username
    
    # Submit login form
    Click Login Button
    
    # Verify login error for empty username
    Verify Login Error    This field is required
    
    # Take screenshot showing validation error
    Take Screenshot With Timestamp    login_empty_username_error

Login Fails With Empty Password
    [Documentation]    Test login failure when password field is empty
    [Tags]    negative    login    validation
    
    # Take screenshot before login attempt
    Take Screenshot With Timestamp    login_page_before_empty_password
    
    # Input valid username with empty password
    Input Login Details    ${VALID_USERNAME}    ${EMPTY_PASSWORD}
    
    # Take screenshot after filling login form
    Take Screenshot With Timestamp    login_form_filled_empty_password
    
    # Submit login form
    Click Login Button
    
    # Verify login error for empty password
    Verify Login Error    This field is required
    
    # Take screenshot showing validation error
    Take Screenshot With Timestamp    login_empty_password_error

Login Fails With Both Fields Empty
    [Documentation]    Test login failure when both username and password fields are empty
    [Tags]    negative    login    validation
    
    # Take screenshot before login attempt
    Take Screenshot With Timestamp    login_page_before_both_empty
    
    # Leave both fields empty
    Input Login Details    ${EMPTY_USERNAME}    ${EMPTY_PASSWORD}
    
    # Take screenshot after leaving form empty
    Take Screenshot With Timestamp    login_form_both_empty
    
    # Submit login form
    Click Login Button
    
    # Verify login error for empty fields
    Verify Login Error    This field is required
    
    # Take screenshot showing validation errors
    Take Screenshot With Timestamp    login_both_empty_error

Login Session Persistence Check
    [Documentation]    Test that login session persists across page navigation
    [Tags]    positive    login    session
    
    # First login successfully
    Input Login Details    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Login Button
    Verify Successful Login
    
    # Take screenshot after login
    Take Screenshot With Timestamp    login_session_dashboard
    
    # Navigate away and back to dashboard
    Go To    ${BASE_URL}
    Open Dashboard
    
    # Verify user is still logged in
    Page Should Contain    Dashboard
    
    # Take screenshot showing persistent session
    Take Screenshot With Timestamp    login_session_persistent