#!/bin/bash
#-------------------------------------------------------------------------------

# For now we install these through the repos for testing purposes

# Install the nucleon gem
rm -Rf /tmp/nucleon
mkdir /tmp/nucleon || exit 100

git clone --branch 0.1 git://github.com/coralnexus/nucleon.git /tmp/nucleon || exit 101
gem install /tmp/nucleon/nucleon-*.gem || exit 102

# Install the corl gem
rm -Rf /tmp/corl
mkdir /tmp/corl || exit 103

git clone --branch 0.4 git://github.com/coralnexus/corl.git /tmp/corl || exit 104
gem install /tmp/corl/corl-*.gem || exit 105
