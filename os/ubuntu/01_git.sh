#!/bin/bash
#-------------------------------------------------------------------------------

# Install Git.
apt-get -y install git || exit 10

# Make sure it is easy to communicate with repo hosts
mkdir -p "/root/.ssh" || exit 11
touch "/root/.ssh/known_hosts" || exit 12

ssh-keygen -R github.com 2>&1 || exit 13 # No duplicates
ssh-keyscan -H github.com >> "/root/.ssh/known_hosts" || exit 14