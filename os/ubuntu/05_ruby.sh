#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.
add-apt-repository ppa:brightbox/ruby-ng-experimental

apt-get -y install ruby2.1 ruby2.1-dev || exit 51
update-alternatives --set ruby /usr/bin/ruby2.1 || exit 52
update-alternatives --set gem /usr/bin/gem2.1 || exit 53

# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "$HOME/.gemrc" || exit 54