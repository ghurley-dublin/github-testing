#!/bin/bash
# Determine if the following files changed in the branch
echo "Checking for modifications to files that should not be changed..."
git diff --exit-code HEAD^1 HEAD LICENSE scripts
if [ $? -eq 0 ]; then
	echo "SUCCESS: Key files unchanged in last commit"
	exit 0
else
	echo "FAILURE: Key file(s) modified in last commit" >&2
	exit 1
fi


