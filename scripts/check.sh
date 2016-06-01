#!/bin/bash

git rev-list HEAD | tail -n 1
exit 1