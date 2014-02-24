#!/bin/bash
#-------------------------------------------------------------------------------

# For now we install CORL through the repo for testing purposes

# Install the corl gem
rm -Rf /tmp/corl
mkdir /tmp/corl || exit 100

cd /tmp/corl || exit 101
git clone --branch 0.4 git://github.com/coralnexus/corl.git /tmp/corl || exit 102
git submodule update --init --recursive || exit 103
gem build /tmp/corl/corl.gemspec || exit 104
gem install /tmp/corl/corl-*.gem || exit 105
