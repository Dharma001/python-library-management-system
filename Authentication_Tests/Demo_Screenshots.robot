*** Settings ***
Documentation    Demo Robot Framework test to show screenshot functionality
Library          SeleniumLibrary
Library          DateTime

*** Variables ***
${DEMO_URL}      https://www.google.com
${BROWSER}       Chrome
${TIMEOUT}       10s

*** Keywords ***
Take Screenshot With Timestamp
    [Documentation]    Take screenshot with timestamp for reporting
    [Arguments]    ${filename}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Capture Page Screenshot    ${filename}_${timestamp}.png

*** Test Cases ***
Demo Screenshot Test
    [Documentation]    Demonstrates Robot Framework screenshot capture functionality
    [Tags]    demo    screenshot
    
    # Open browser to a public URL that's always available
    Open Browser    ${DEMO_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}
    
    # Take initial screenshot
    Take Screenshot With Timestamp    demo_page_loaded
    
    # Wait a moment for page to load completely
    Sleep    2s
    
    # Take another screenshot
    Take Screenshot With Timestamp    demo_page_ready
    
    # Verify page contains expected content
    Page Should Contain    Google
    
    # Take final screenshot
    Take Screenshot With Timestamp    demo_page_verified
    
    # Close browser
    Close Browser