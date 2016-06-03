#!/bin/bash
# Determine if the following files changed in the branch
set -x
echo "Checking POM dependencies for changes..."

mkdir temp
mvn dependency:tree -Doutput=temp/current-tree.txt

checkout HEAD^1
mvn dependency:tree -Doutput=temp/old-tree.txt

echo "Current..."
cat temp/current-tree.txt
echo "------------------------------------"
echo "Old..."
cat temp/old-tree.txt
echo "------------------------------------"

$DIFF=`diff -q temp/current-tree.txt temp/old-tree.txt`

if [ -n "$DIFF" ]; then
	echo "WARNING: POM dependency tree changed in latest commit"
	diff -y temp/current-tree.txt temp/old-tree.txt
fi

echo "STATUS: WARNING"
