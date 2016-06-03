#!/bin/bash
# Determine if the following files changed in the branch
echo "Checking POM dependencies for changes..."

mkdir temp
mvn dependency:tree -Doutput=temp/current-tree.txt

checkout HEAD^1
mvn dependency:tree -Doutput=temp/old-tree.txt

diff --exit-code temp/current-tree.txt temp/old-tree.txt
