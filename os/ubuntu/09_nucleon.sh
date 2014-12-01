#!/bin/bash
#-------------------------------------------------------------------------------

# Uninstall the nucleon gem

echo "1. Removing old versions of Nucleon gem"
su - -c "gem uninstall nucleon -x --force" root >/tmp/nucleon.uninstall.log 2>&1 || exit 90

# Install the nucleon gem

if [ "$DEVELOPMENT_BUILD" ]
then
  rm -Rf /tmp/nucleon
  mkdir /tmp/nucleon || exit 91

  cd /tmp/nucleon || exit 92

  echo "2. Fetching Nucleon source repository"
  git clone --branch 0.2 git://github.com/coralnexus/nucleon.git /tmp/nucleon >/tmp/nucleon.git.log 2>&1 || exit 93
  git submodule update --init --recursive >>/tmp/nucleon.git.log 2>&1 || exit 94

  echo "3. Building Nucleon gem from branch 0.2"
  su - -c "cd /tmp/nucleon; gem build /tmp/nucleon/nucleon.gemspec" root >/tmp/nucleon.build.log 2>&1 || exit 95
  
  echo "4. Installing latest dev build of Nucleon"
  su - -c "cd /tmp/nucleon; gem install /tmp/nucleon/nucleon-*.gem" root >/tmp/nucleon.install.log 2>&1 || exit 96
else 
  echo "2. Installing latest release of Nucleon"
  su - -c "gem install nucleon" root >/tmp/nucleon.install.log 2>&1 || exit 91  
fi