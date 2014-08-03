#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.
case "$OS_VERSION" in
'14.04')
    apt-get -y install ruby1.9.1 ruby1.9.1-dev || exit 50
;;
'12.04')
    add-apt-repository -y ppa:brightbox/ruby-ng-experimental 2>&1 || exit 51
    apt-get update || exit 52

    apt-get -y install ruby2.0 ruby2.0-dev || exit 53
    update-alternatives --set ruby /usr/bin/ruby2.0 || exit 54
    update-alternatives --set gem /usr/bin/gem2.0 || exit 55
;;
esac

# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "$HOME/.gemrc" || exit 56