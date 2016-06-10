#!/bin/bash
# Determine if the following files changed in the branch
echo "-----------------------------------------------------------"
echo "Checking for modifications to files that should not be changed..."
echo "-----------------------------------------------------------"
git diff --exit-code HEAD^1 HEAD LICENSE
if [ $? -eq 0 ]; then
	echo "SUCCESS: Files that shouldn't be modified were not changed in last commit"
	exit 0
else
	echo "FAILURE: Files that shouldn't be modified were unexpectedly modified in last commit" >&2
	exit 1
fi
echo "-----------------------------------------------------------"
