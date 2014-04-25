#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.
apt-get -y install ruby1.9.1 ruby1.9.1-dev || exit 50

# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "$HOME/.gemrc" || exit 51