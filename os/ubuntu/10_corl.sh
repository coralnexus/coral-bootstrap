#!/bin/bash
#-------------------------------------------------------------------------------

# For now we install these through the repos for testing purposes

# Install the nucleon gem
rm -Rf /tmp/nucleon
mkdir /tmp/nucleon || exit 100

cd /tmp/nucleon || exit 101
git clone --branch 0.1 git://github.com/coralnexus/nucleon.git /tmp/nucleon || exit 102
gem build /tmp/nucleon/nucleon.gemspec || exit 103
gem install /tmp/nucleon/nucleon-*.gem || exit 104

# Install the corl gem
rm -Rf /tmp/corl
mkdir /tmp/corl || exit 105

cd /tmp/corl || exit 106
git clone --branch 0.4 git://github.com/coralnexus/corl.git /tmp/corl || exit 107
gem build /tmp/corl/corl.gemspec || exit 108
gem install /tmp/corl/corl-*.gem || exit 109
