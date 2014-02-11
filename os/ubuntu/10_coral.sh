#!/bin/bash
#-------------------------------------------------------------------------------

# Install the Coral core gem
rm -Rf /tmp/coral
mkdir /tmp/coral || exit 100

git clone --branch 0.2 git://github.com/coralnexus/ruby-coral_core.git /tmp/coral || exit 101
gem install /tmp/coral/coral_core-*.gem || exit 102
