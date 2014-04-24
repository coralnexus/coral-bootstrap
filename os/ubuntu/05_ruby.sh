#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.
add-apt-repository -y ppa:brightbox/ruby-ng-experimental 2>&1 || exit 51
apt-get update || exit 52

apt-get -y install ruby2.0 ruby2.0-dev || exit 53
update-alternatives --set ruby /usr/bin/ruby2.0 || exit 54
update-alternatives --set gem /usr/bin/gem2.0 || exit 55

# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "$HOME/.gemrc" || exit 56