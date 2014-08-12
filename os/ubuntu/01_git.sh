#!/bin/bash
#-------------------------------------------------------------------------------

# Install Git.
echo "1. Ensuring Git"
apt-get -y install git >/tmp/git.install.log 2>&1 || exit 10

# Make sure it is easy to communicate with repo hosts
echo "2. Adding GitHub to root known hosts"

mkdir -p "/root/.ssh" || exit 11
touch "/root/.ssh/known_hosts" || exit 12

ssh-keygen -R github.com >/dev/null 2>&1 || exit 13 # No duplicates
ssh-keyscan -H github.com >> "/root/.ssh/known_hosts" 2>/dev/null || exit 14