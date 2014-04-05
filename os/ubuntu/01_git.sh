#!/bin/bash
#-------------------------------------------------------------------------------

# Install Git.
apt-get -y install git || exit 10

# Make sure it is easy to communicate with repo hosts
ssh-keygen -R github.com 2>&1 || exit 11 # No duplicates
ssh-keyscan -H github.com >> ~/.ssh/known_hosts || exit 12