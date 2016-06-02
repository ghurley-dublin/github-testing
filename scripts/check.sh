#!/bin/bash
# Determine if the following files changed in the branch
echo "Checking for modifications to files that should not be changed"
git diff --exit-code HEAD^1 HEAD LICENSE