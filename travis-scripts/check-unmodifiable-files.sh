#!/bin/bash
# Determine if the following files changed in the branch
UNMODIFIABLE="LICENSE travis-scripts"
echo "-----------------------------------------------------------"
echo "Checking for modifications to files that should not be changed..."
echo "-----------------------------------------------------------"
if [ "${TRAVIS_PULL_REQUEST}" = true]; then
	echo "Comparing HEAD against pending commit..."
	git diff --exit-code HEAD LICENSE
else
	echo "Comparing HEAD against previous commit ..."
	git diff --exit-code HEAD^1 HEAD LICENSE
fi

if [ $? -eq 0 ]; then
	echo "SUCCESS: Files '$UNMODIFIABLE' that shouldn't be modified unchanged in last commit"
	exit 0
else
	echo "FAILURE: Files '$UNMODIFIABLE' that shouldn't be modified were unexpectedly modified in last commit" >&2
	exit 1
fi
echo "-----------------------------------------------------------"
