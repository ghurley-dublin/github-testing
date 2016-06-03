#!/bin/bash
# Determine if the following files changed in the branch
echo "Checking POM dependencies for changes..."

mkdir temp
mvn dependency:tree -Doutput=temp/current-tree.txt

git checkout HEAD^1
mvn dependency:tree -Doutput=temp/old-tree.txt

echo "---- Latest dependencies..."
cat temp/current-tree.txt
echo "------------------------------------"
echo "---- Previous dependencies..."
cat temp/old-tree.txt
echo "------------------------------------"

DIFF=`diff -q temp/current-tree.txt temp/old-tree.txt`

if [ -n "$DIFF" ]; then
	echo "POM dependency tree changed in latest commit"
	echo "Side-by-side diff (left=LATEST      right=PREVIOUS)"
	diff -y temp/current-tree.txt temp/old-tree.txt
	echo "STATUS -- WARNING: POM changes detected"
else
	echo "STATUS -- SUCCESS: POM dependencies unchanged"
fi

git checkout master
