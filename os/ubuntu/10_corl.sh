#!/bin/bash
#-------------------------------------------------------------------------------

# Uninstall the CORL gem

echo "1. Removing old versions of CORL gem"
su - -c "gem uninstall corl -x --force" root >/tmp/corl.uninstall.log 2>&1 || exit 101

# Install the CORL gem

if [ "$DEVELOPMENT_BUILD" ]
then
  rm -Rf /tmp/corl
  mkdir /tmp/corl || exit 102

  cd /tmp/corl || exit 103

  echo "2. Fetching CORL source repository"
  git clone --branch 0.5 git://github.com/coralnexus/corl.git /tmp/corl >/tmp/corl.git.log 2>&1 || exit 104
  git submodule update --init --recursive >>/tmp/corl.git.log 2>&1 || exit 105

  echo "3. Building CORL gem from branch 0.5"
  su - -c "cd /tmp/corl; gem build /tmp/corl/corl.gemspec" root >/tmp/corl.build.log 2>&1 || exit 106

  echo "4. Installing latest dev build of CORL"
  su - -c "cd /tmp/corl; gem install /tmp/corl/corl-*.gem" root >/tmp/corl.install.log 2>&1 || exit 107
else
  echo "2. Installing latest release of CORL"
  su - -c "gem install corl" root >/tmp/corl.install.log 2>&1 || exit 102
fi