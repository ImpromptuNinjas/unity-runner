#!/usr/bin/env bash

#
# Set and display project path
#

UNITY_PROJECT_PATH="$GITHUB_WORKSPACE/$PROJECT_PATH"
echo "Using project path \"$UNITY_PROJECT_PATH\"."

#
# Set and display the artifacts path
#

echo "Using artifacts path \"$ARTIFACTS_PATH\" to save test results."
FULL_ARTIFACTS_PATH=$GITHUB_WORKSPACE/$ARTIFACTS_PATH

#
# Display custom parameters
#
echo "Using custom parameters $CUSTOM_PARAMETERS."

# The following tests are 2019 mode (requires Unity 2019.2.11f1 or later)
# Reference: https://docs.unity3d.com/2019.3/Documentation/Manual/CommandLineArguments.html

#
# Display the unity version
#

echo "Using Unity version \"$UNITY_VERSION\" to test."

#
# Overall info
#

echo ""
echo "###########################"
echo "#    Project directory    #"
echo "###########################"
echo ""
ls -alh $UNITY_PROJECT_PATH

#
# Run Unity
#

echo ""
echo "###########################"
echo "#     Unity Execution     #"
echo "###########################"
echo ""

set +e

xvfb-run --auto-servernum --server-args='-screen 0 640x480x24' \
  /opt/Unity/Editor/Unity \
    -batchmode -stackTraceLogType Full -logFile - \
    -projectPath "$UNITY_PROJECT_PATH" \
    $CUSTOM_PARAMETERS

# Catch exit code
EXIT_CODE=$?

set -e
    
# Display results
if [ $EXIT_CODE -eq 0 ]; then
  echo "Run succeeded, no failures occurred";
elif [ $EXIT_CODE -eq 2 ]; then
  echo "Run succeeded, some tests failed";
elif [ $EXIT_CODE -eq 3 ]; then
  echo "Run failure (other failure)";
else
  echo "Unexpected exit code $EXIT_CODE";
fi

#
# Results
#

echo ""
echo "###########################"
echo "#    Project directory    #"
echo "###########################"
echo ""
ls -alh $UNITY_PROJECT_PATH

#
# Exit
#

if [ $EXIT_CODE -gt 0 ]; then
  TEST_RUNNER_EXIT_CODE=$EXIT_CODE
fi