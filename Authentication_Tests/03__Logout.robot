*** Settings ***
Documentation    Robot Framework test cases for Logout functionality using SeleniumLibrary
Resource         Authentication_Resources.robot
Suite Setup      Open Browser To Base URL
Suite Teardown   Close Test Browser

*** Variables ***
${VALID_USERNAME}    admin
${VALID_PASSWORD}    admin123

*** Test Cases ***
Logout Successfully Clears Session And Redirects To Homepage
    [Documentation]    Test successful logout that clears user session and redirects to homepage
    [Tags]    positive    logout    critical
    
    # First login to establish session
    Open Login Page
    Input Login Details    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Login Button
    Verify Successful Login
    
    # Take screenshot showing logged in state
    Take Screenshot With Timestamp    logout_before_logged_in_dashboard
    
    # Perform logout
    Click Logout Button
    
    # Verify successful logout and redirection
    Verify Successful Logout
    
    # Take screenshot after logout
    Take Screenshot With Timestamp    logout_successful_homepage

Restricted Access To Dashboard After Logout
    [Documentation]    Test that dashboard is not accessible after logout (session cleared)
    [Tags]    positive    logout    security
    
    # First login to establish session
    Open Login Page
    Input Login Details    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Login Button
    Verify Successful Login
    
    # Take screenshot showing authenticated dashboard access
    Take Screenshot With Timestamp    logout_authenticated_dashboard_access
    
    # Perform logout
    Click Logout Button
    Verify Successful Logout
    
    # Take screenshot after logout
    Take Screenshot With Timestamp    logout_after_successful_logout
    
    # Attempt to access dashboard after logout
    Verify Restricted Access After Logout
    
    # Take screenshot showing restricted access
    Take Screenshot With Timestamp    logout_restricted_access_denied

Logout Button Visibility When Logged In
    [Documentation]    Test that logout button is visible and accessible when user is logged in
    [Tags]    positive    logout    ui
    
    # Login first
    Open Login Page
    Input Login Details    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Login Button
    Verify Successful Login
    
    # Check logout button visibility
    Page Should Contain Element    ${LOGOUT_BUTTON}
    Element Should Be Visible      ${LOGOUT_BUTTON}
    
    # Take screenshot showing logout button visibility
    Take Screenshot With Timestamp    logout_button_visible_when_logged_in

Multiple Logout Attempts
    [Documentation]    Test behavior when logout is attempted multiple times
    [Tags]    negative    logout    edge_case
    
    # Login first
    Open Login Page
    Input Login Details    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Login Button
    Verify Successful Login
    
    # First logout
    Click Logout Button
    Verify Successful Logout
    
    # Take screenshot after first logout
    Take Screenshot With Timestamp    logout_first_logout_complete
    
    # Attempt second logout (should handle gracefully)
    Go To    ${DASHBOARD_URL}
    
    # Should be redirected or show appropriate message
    ${current_url}=    Get Location
    Should Not Be Equal    ${current_url}    ${DASHBOARD_URL}
    
    # Take screenshot showing second logout attempt result
    Take Screenshot With Timestamp    logout_second_attempt_handled

Direct Dashboard Access Without Login
    [Documentation]    Test that dashboard requires authentication (no existing session)
    [Tags]    negative    logout    security
    
    # Ensure no existing session by attempting direct dashboard access
    Go To    ${DASHBOARD_URL}
    
    # Should not be able to access dashboard
    ${current_url}=    Get Location
    Should Not Be Equal    ${current_url}    ${DASHBOARD_URL}
    
    # Take screenshot showing access denied without login
    Take Screenshot With Timestamp    logout_direct_access_denied

Session Timeout Simulation
    [Documentation]    Test logout behavior after potential session timeout
    [Tags]    negative    logout    session
    
    # Login first
    Open Login Page
    Input Login Details    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Login Button
    Verify Successful Login
    
    # Take screenshot of authenticated session
    Take Screenshot With Timestamp    logout_session_before_timeout
    
    # Simulate session timeout by waiting (if applicable) or clearing cookies
    Delete All Cookies
    
    # Try to access dashboard
    Go To    ${DASHBOARD_URL}
    
    # Should be redirected to login
    ${current_url}=    Get Location
    Should Not Be Equal    ${current_url}    ${DASHBOARD_URL}
    
    # Take screenshot showing session timeout effect
    Take Screenshot With Timestamp    logout_session_timeout_redirect

Back Button After Logout
    [Documentation]    Test that using browser back button after logout doesn't restore session
    [Tags]    negative    logout    security
    
    # Login and navigate to dashboard
    Open Login Page
    Input Login Details    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Login Button
    Verify Successful Login
    
    # Take screenshot of authenticated state
    Take Screenshot With Timestamp    logout_before_back_button_test
    
    # Logout
    Click Logout Button
    Verify Successful Logout
    
    # Use browser back button
    Go Back
    
    # Should not restore authenticated session
    ${current_url}=    Get Location
    Should Not Be Equal    ${current_url}    ${DASHBOARD_URL}
    
    # Take screenshot showing back button doesn't restore session
    Take Screenshot With Timestamp    logout_back_button_no_restore