#!/bin/bash
#-------------------------------------------------------------------------------

# Install Git.
apt-get -y install git || exit 10

echo "Hello $USER"

# Make sure it is easy to communicate with repo hosts
mkdir -p ~/.ssh || exit 11
touch ~/.ssh/known_hosts || exit 12

ssh-keygen -R github.com 2>&1 || exit 13 # No duplicates
ssh-keyscan -H github.com >> ~/.ssh/known_hosts || exit 14