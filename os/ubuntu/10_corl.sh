#!/bin/bash
#-------------------------------------------------------------------------------

# Install the corl gem
rm -Rf /tmp/corl
mkdir /tmp/corl || exit 100

git clone --branch 0.4 git://github.com/coralnexus/corl.git /tmp/corl || exit 101
gem install /tmp/corl/corl-*.gem || exit 102
