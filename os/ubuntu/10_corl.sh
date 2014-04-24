#!/bin/bash
#-------------------------------------------------------------------------------

# For now we install CORL through the repo for testing purposes

# Install this dependency separately so the damn thing will build.
# I REALLY dislike Nokogiri.
# TODO: Figure out why this is happening?
gem install nokogiri || exit 100

# Install the corl gem
rm -Rf /tmp/corl
mkdir /tmp/corl || exit 101

cd /tmp/corl || exit 102
git clone --branch 0.4 git://github.com/coralnexus/corl.git /tmp/corl || exit 103
git submodule update --init --recursive || exit 104
gem build /tmp/corl/corl.gemspec || exit 105
gem install /tmp/corl/corl-*.gem || exit 106
