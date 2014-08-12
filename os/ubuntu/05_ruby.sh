#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.
echo "Installing Ruby 2.1.2"
wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz --output-document=/tmp/ruby2.1.2.tar.gz -q || exit 50
tar -xzvf /tmp/ruby2.1.2.tar.gz --directory=/tmp 1>/dev/null || exit 51

/tmp/ruby-2.1.2/configure --quiet || exit 52
make --directory=/tmp/ruby-2.1.2 --quiet || exit 53
make install --directory=/tmp/ruby-2.1.2 --quiet || exit 54

# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "$HOME/.gemrc" || exit 56