#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.
apt-get -y install ruby1.9.1 ruby1.9.1-dev || exit 50
update-alternatives --set ruby /usr/bin/ruby1.9.1 || exit 51
update-alternatives --set gem /usr/bin/gem1.9.1 || exit 52

# Set gem options
( cat <<'EOP'
gem: --no-document
EOP
) > "$HOME/.gemrc" || exit 53