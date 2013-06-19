#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.
apt-get -y install ruby1.9.1 ruby1.9.1-dev
update-alternatives --set ruby /usr/bin/ruby1.9.1
update-alternatives --set gem /usr/bin/gem1.9.1
