*** Settings ***
Documentation    Robot Framework test cases for Signup page using SeleniumLibrary
Resource         Authentication_Resources.robot
Suite Setup      Open Browser To Base URL
Suite Teardown   Close Test Browser
Test Setup       Open Signup Page

*** Variables ***
${VALID_USERNAME}       testuser001
${VALID_EMAIL}          testuser001@example.com
${VALID_PASSWORD}       SecurePass123!
${DUPLICATE_USERNAME}   admin
${INVALID_USERNAME}     us
${INVALID_EMAIL}        invalid-email
${WEAK_PASSWORD}        123

*** Test Cases ***
Successful Signup With Valid Credentials
    [Documentation]    Test successful user signup with valid username, email, and password
    [Tags]    positive    signup    critical
    
    # Take screenshot before signup attempt
    Take Screenshot With Timestamp    signup_page_before_valid
    
    # Input valid signup details
    Input Signup Details    ${VALID_USERNAME}    ${VALID_EMAIL}    ${VALID_PASSWORD}    ${VALID_PASSWORD}
    
    # Take screenshot after filling form
    Take Screenshot With Timestamp    signup_form_filled_valid
    
    # Submit signup form
    Click Signup Button
    
    # Verify successful signup
    Verify Successful Signup
    
    # Take screenshot after successful signup
    Take Screenshot With Timestamp    signup_success

Signup Fails With Duplicate Username
    [Documentation]    Test signup failure when attempting to register with an existing username
    [Tags]    negative    signup    duplicate
    
    # Take screenshot before signup attempt
    Take Screenshot With Timestamp    signup_page_before_duplicate
    
    # Input duplicate username with valid other details
    Input Signup Details    ${DUPLICATE_USERNAME}    testuser002@example.com    ${VALID_PASSWORD}    ${VALID_PASSWORD}
    
    # Take screenshot after filling form
    Take Screenshot With Timestamp    signup_form_filled_duplicate
    
    # Submit signup form
    Click Signup Button
    
    # Verify signup error for duplicate username
    Verify Signup Error    username already exists
    
    # Take screenshot showing error message
    Take Screenshot With Timestamp    signup_duplicate_error

Signup Fails With Invalid Username
    [Documentation]    Test signup failure with invalid username (too short)
    [Tags]    negative    signup    validation
    
    # Take screenshot before signup attempt
    Take Screenshot With Timestamp    signup_page_before_invalid
    
    # Input invalid username (too short)
    Input Signup Details    ${INVALID_USERNAME}    testuser003@example.com    ${VALID_PASSWORD}    ${VALID_PASSWORD}
    
    # Take screenshot after filling form
    Take Screenshot With Timestamp    signup_form_filled_invalid
    
    # Submit signup form
    Click Signup Button
    
    # Verify signup error for invalid username
    Verify Signup Error    username must be at least
    
    # Take screenshot showing validation error
    Take Screenshot With Timestamp    signup_invalid_username_error

Signup Fails With Invalid Email Format
    [Documentation]    Test signup failure with invalid email format
    [Tags]    negative    signup    validation
    
    # Take screenshot before signup attempt
    Take Screenshot With Timestamp    signup_page_before_invalid_email
    
    # Input invalid email format
    Input Signup Details    testuser004    ${INVALID_EMAIL}    ${VALID_PASSWORD}    ${VALID_PASSWORD}
    
    # Take screenshot after filling form
    Take Screenshot With Timestamp    signup_form_filled_invalid_email
    
    # Submit signup form
    Click Signup Button
    
    # Verify signup error for invalid email
    Verify Signup Error    Enter a valid email address
    
    # Take screenshot showing email validation error
    Take Screenshot With Timestamp    signup_invalid_email_error

Signup Fails With Password Mismatch
    [Documentation]    Test signup failure when password confirmation doesn't match
    [Tags]    negative    signup    validation
    
    # Take screenshot before signup attempt
    Take Screenshot With Timestamp    signup_page_before_password_mismatch
    
    # Input mismatched passwords
    Input Signup Details    testuser005    testuser005@example.com    ${VALID_PASSWORD}    DifferentPassword123!
    
    # Take screenshot after filling form
    Take Screenshot With Timestamp    signup_form_filled_password_mismatch
    
    # Submit signup form
    Click Signup Button
    
    # Verify signup error for password mismatch
    Verify Signup Error    password confirmation doesn't match
    
    # Take screenshot showing password mismatch error
    Take Screenshot With Timestamp    signup_password_mismatch_error

Signup Fails With Weak Password
    [Documentation]    Test signup failure with weak/simple password
    [Tags]    negative    signup    validation
    
    # Take screenshot before signup attempt
    Take Screenshot With Timestamp    signup_page_before_weak_password
    
    # Input weak password
    Input Signup Details    testuser006    testuser006@example.com    ${WEAK_PASSWORD}    ${WEAK_PASSWORD}
    
    # Take screenshot after filling form
    Take Screenshot With Timestamp    signup_form_filled_weak_password
    
    # Submit signup form
    Click Signup Button
    
    # Verify signup error for weak password
    Verify Signup Error    password is too common
    
    # Take screenshot showing weak password error
    Take Screenshot With Timestamp    signup_weak_password_error