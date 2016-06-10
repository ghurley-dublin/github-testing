#!/bin/bash
# Determine if the following files changed in the branch
echo "-----------------------------------------------------------"
echo "Checking for modifications to files that should not be changed..."
echo "-----------------------------------------------------------"
echo "Value of env variable TRAVIS_PULL_REQUEST=${TRAVIS_PULL_REQUEST}"
if [ "${TRAVIS_PULL_REQUEST}" = true]; then
	echo "Comparing HEAD against pending commit..."
	git diff --exit-code HEAD LICENSE
else
	echo "Comparing HEAD against previous commit ..."
	git diff --exit-code HEAD^1 HEAD LICENSE
fi

if [ $? -eq 0 ]; then
	echo "SUCCESS: Files that shouldn't be modified were not changed in last commit"
	exit 0
else
	echo "FAILURE: Files that shouldn't be modified were unexpectedly modified in last commit" >&2
	exit 1
fi
echo "-----------------------------------------------------------"
