#!/bin/bash
#-------------------------------------------------------------------------------

# For now we install Nucleon through the repo for testing purposes

# Install the nucleon gem
rm -Rf /tmp/nucleon
mkdir /tmp/nucleon || exit 90

cd /tmp/nucleon || exit 101
git clone --branch 0.2 git://github.com/coralnexus/nucleon.git /tmp/nucleon || exit 91
git submodule update --init --recursive || exit 92
gem build /tmp/nucleon/nucleon.gemspec || exit 93
gem install /tmp/nucleon/nucleon-*.gem || exit 94
