#!/bin/bash
#-------------------------------------------------------------------------------

# For now we install CORL through the repo for testing purposes

if [ `gem list -i nokogiri` != "true" ]
then
    echo "1. Installing Nokogiri"
    gem install nokogiri >/tmp/nokogiri.install.log 2>&1 || exit 100
fi

# Install the corl gem
rm -Rf /tmp/corl
mkdir /tmp/corl || exit 101

cd /tmp/corl || exit 102

echo "2. Fetching CORL source repository"
git clone --branch 0.5 git://github.com/coralnexus/corl.git /tmp/corl >/tmp/corl.git.log 2>&1 || exit 103
git submodule update --init --recursive >>/tmp/corl.git.log 2>&1 || exit 104

echo "3. Building CORL gem from branch 0.5"
gem build /tmp/corl/corl.gemspec >/tmp/corl.build.log 2>&1 || exit 105

echo "4. Installing latest CORL"
gem install /tmp/corl/corl-*.gem >/tmp/corl.install.log 2>&1 || exit 106
