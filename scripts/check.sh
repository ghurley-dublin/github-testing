#!/bin/bash
# Determine if the following files changed in the branch
echo "Checking for modifications to files that should not be changed"
git diff --exit-code --name-only `git rev-list HEAD | tail -n 2 | head -n 1` HEAD LICENSE