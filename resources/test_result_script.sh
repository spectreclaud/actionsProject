#!/usr/bin/bash

###################################################################################################
#     This is extracting the values for each test suite description.                              #
#     It uses awk to print the value between two quotes.                                          #
#     The columns printed is based on the following example string:                               #
#     <testng-results ignored="0" total="23" passed="22" failed="1" skipped="0">                  #
###################################################################################################

TEST_RESULTS_LOCATION="${1:-$(pwd)/target/surefire-reports}"

echo "Using test results location: $TEST_RESULTS_LOCATION"

# Check if the test results directory exists
if [ -d "$TEST_RESULTS_LOCATION" ]; then
    echo "Test results directory found at $TEST_RESULTS_LOCATION."

    # Reading and extracting values from the testng-results.xml
    TEST_RESULTS_STRING=$(cat "${TEST_RESULTS_LOCATION}/testng-results.xml" | grep "<testng-results")
    echo "IGNORED_TESTS=$(echo ${TEST_RESULTS_STRING} | awk -F'"' '{ print $2 }')" >> $GITHUB_ENV
    echo "TOTAL_TESTS=$(echo ${TEST_RESULTS_STRING} | awk -F'"' '{ print $4 }')" >> $GITHUB_ENV
    echo "PASSED_TESTS=$(echo ${TEST_RESULTS_STRING} | awk -F'"' '{ print $6 }')" >> $GITHUB_ENV
    echo "FAILED_TESTS=$(echo ${TEST_RESULTS_STRING} | awk -F'"' '{ print $8 }')" >> $GITHUB_ENV
    echo "SKIPPED_TESTS=$(echo ${TEST_RESULTS_STRING} | awk -F'"' '{ print $10 }')" >> $GITHUB_ENV

else
    echo "Test results directory not found at $TEST_RESULTS_LOCATION."
    exit 1
fi
