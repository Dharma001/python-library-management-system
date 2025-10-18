# Robot Framework Authentication Test Suite - Execution Guide

## Prerequisites

Before running the tests, ensure you have the following installed:

```bash
# Install Robot Framework
pip install robotframework

# Install SeleniumLibrary for Robot Framework
pip install robotframework-seleniumlibrary

# Install Chrome WebDriver (or your preferred browser driver)
# For Chrome: Download ChromeDriver from https://chromedriver.chromium.org/
# Ensure ChromeDriver is in your system PATH
```

## Project Structure

```
Authentication_Tests/
├── 01__Signup.robot                 # Signup functionality tests
├── 02__Login.robot                  # Login functionality tests  
├── 03__Logout.robot                 # Logout functionality tests
└── Authentication_Resources.robot    # Reusable keywords and variables
```

## Running Tests

### 1. Run All Authentication Tests in Sequence

```bash
# Navigate to your project directory
cd "c:\Dharma CDU\projects\pl"

# Run all tests in the Authentication_Tests directory
robot Authentication_Tests/

# Alternative: Run with specific output directory
robot --outputdir results Authentication_Tests/
```

### 2. Run Individual Test Suites

```bash
# Run only Signup tests
robot Authentication_Tests/01__Signup.robot

# Run only Login tests  
robot Authentication_Tests/02__Login.robot

# Run only Logout tests
robot Authentication_Tests/03__Logout.robot
```

### 3. Run Tests with Tags

```bash
# Run only critical tests
robot --include critical Authentication_Tests/

# Run only positive test cases
robot --include positive Authentication_Tests/

# Run only negative test cases
robot --include negative Authentication_Tests/

# Run specific functionality tests
robot --include signup Authentication_Tests/
robot --include login Authentication_Tests/
robot --include logout Authentication_Tests/
```

### 4. Run Tests with Custom Browser

```bash
# Run tests with Firefox instead of Chrome
robot --variable BROWSER:Firefox Authentication_Tests/

# Run tests in headless mode (Chrome)
robot --variable BROWSER:Chrome --variable CHROME_OPTIONS:add_argument("--headless") Authentication_Tests/
```

### 5. Generate Detailed Reports

```bash
# Run tests with custom report names
robot --report custom_report.html --log custom_log.html Authentication_Tests/

# Run with timestamp in report names
robot --timestampoutputs Authentication_Tests/
```

## Generated Output Files

After test execution, the following files will be generated:

### 1. **log.html**
- Detailed test execution log with step-by-step information
- Shows passed/failed tests with error details
- Contains screenshots captured during test execution

### 2. **report.html** 
- High-level test execution summary
- Test statistics and pass/fail ratios
- Tag-based test categorization

### 3. **output.xml**
- Machine-readable test results in XML format
- Used for CI/CD integration and result parsing
- Contains all test data and execution details

## Advanced Execution Options

### Parallel Test Execution
```bash
# Install pabot for parallel execution
pip install robotframework-pabot

# Run tests in parallel (2 processes)
pabot --processes 2 Authentication_Tests/
```

### Custom Test Variables
```bash
# Override default variables
robot --variable BASE_URL:http://localhost:8000 Authentication_Tests/
robot --variable TIMEOUT:15s Authentication_Tests/
robot --variable BROWSER:Firefox Authentication_Tests/
```

### Dry Run (Validate Tests Without Execution)
```bash
# Check test syntax without running
robot --dryrun Authentication_Tests/
```

### Re-run Failed Tests
```bash
# First run
robot Authentication_Tests/

# Re-run only failed tests
robot --rerunfailed output.xml Authentication_Tests/
```

## Continuous Integration Example

For CI/CD pipelines, use this command structure:

```bash
robot --outputdir ci_results --report report.html --log log.html --xunit xunit.xml Authentication_Tests/
```

## Test Execution Best Practices

1. **Environment Setup**: Ensure Django server is running before tests
2. **Browser Management**: Close any existing browser instances
3. **Test Data**: Use fresh test data for each run
4. **Screenshots**: Enable screenshot capture for debugging
5. **Timeouts**: Adjust timeout values based on system performance

## Troubleshooting

### Common Issues and Solutions

1. **WebDriver Not Found**
   ```bash
   # Ensure ChromeDriver is in PATH or specify location
   robot --variable WEBDRIVER_PATH:/path/to/chromedriver Authentication_Tests/
   ```

2. **Django Server Not Running**
   ```bash
   # Start Django server before running tests
   python manage.py runserver
   ```

3. **Element Not Found Errors**
   - Increase timeout values
   - Verify element locators in Authentication_Resources.robot

4. **Permission Errors**
   ```bash
   # Run with appropriate permissions on Windows
   # Ensure write access to output directory
   ```

## Report Analysis

### Understanding Test Results

- **Green Tests**: Passed successfully
- **Red Tests**: Failed with errors
- **Yellow Tests**: Warnings or non-critical issues

### Key Metrics to Monitor

1. **Pass Rate**: Percentage of successful tests
2. **Execution Time**: Total time for test suite
3. **Error Patterns**: Common failure points
4. **Screenshot Analysis**: Visual verification of test states