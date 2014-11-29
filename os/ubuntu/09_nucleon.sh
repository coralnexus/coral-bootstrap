#!/bin/bash
#-------------------------------------------------------------------------------

# For now we install Nucleon through the repo for testing purposes

# Install the nucleon gem

if [ "$DEVELOPMENT_BUILD" ]
then
  rm -Rf /tmp/nucleon
  mkdir /tmp/nucleon || exit 90

  cd /tmp/nucleon || exit 101

  echo "1. Fetching Nucleon source repository"
  git clone --branch 0.2 git://github.com/coralnexus/nucleon.git /tmp/nucleon >/tmp/nucleon.git.log 2>&1 || exit 91
  git submodule update --init --recursive >>/tmp/nucleon.git.log 2>&1 || exit 92

  echo "2. Building Nucleon gem from branch 0.2"
  gem build /tmp/nucleon/nucleon.gemspec >/tmp/nucleon.build.log 2>&1 || exit 93

  echo "3. Installing latest Nucleon"
  gem install /tmp/nucleon/nucleon-*.gem >/tmp/nucleon.install.log 2>&1 || exit 94
else
  echo "1. Removing old versions of Nucleon gem"
  gem uninstall nucleon --force
  
  echo "2. Installing latest release of Nucleon"
  gem install nucleon  
fi