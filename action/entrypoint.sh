#!/usr/bin/env bash

#
# Run steps
#

source /steps/activate.sh
source /steps/run_command.sh || true
source /steps/return_license.sh

#
# Exit with code from the build step.
#

exit $TEST_RUNNER_EXIT_CODE
