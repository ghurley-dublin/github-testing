#!/bin/bash
# Determine if the following files changed in the branch
if [ "${TRAVIS_PULL_REQUEST}" = false ]; then
	echo "-----------------------------------------------------------"
	echo "Checking POM dependencies for changes..."
	echo "-----------------------------------------------------------"
	mkdir temp
	mvn dependency:tree -Doutput=temp/current-tree.txt
	
	echo "Checking dependencies for previous revision..."
	git checkout HEAD~1
	mvn dependency:tree -Doutput=temp/old-tree.txt

	echo "---- Latest dependencies..."
	cat temp/current-tree.txt
	echo "------------------------------------"

	DIFF=`diff -q temp/current-tree.txt temp/old-tree.txt`

	if [ -n "$DIFF" ]; then
		echo "---- Previous dependencies..."
		cat temp/old-tree.txt
		echo "------------------------------------"
		echo "POM dependency tree changed in latest commit"
		echo "Side-by-side diff (left=LATEST      right=PREVIOUS)"
		diff -y temp/current-tree.txt temp/old-tree.txt
		echo "STATUS -- WARNING: POM changes detected"
	else
		echo "STATUS -- SUCCESS: POM dependencies unchanged"
	fi

	git checkout HEAD
	echo "-----------------------------------------------------------"
fi
