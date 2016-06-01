#!/bin/bash
# Determine if the following files changed in the branch
git diff --name-only `git rev-list HEAD | tail -n 2 | head -n 1` HEAD LICENSE README.md