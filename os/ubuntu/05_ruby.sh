#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.
echo "Installing Ruby 2.1.2"
if [ ! -f /tmp/ruby2.1.2.tar.gz ]
then
    echo "Downloading Ruby tar archive"
    wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz --output-document=/tmp/ruby2.1.2.tar.gz -q || exit 50
    CORL_INSTALL_RUBY="yes"
fi
if [ ! -d /tmp/ruby-2.1.2 ]
then
    echo "Extracting Ruby tar archive"
    tar -xzvf /tmp/ruby2.1.2.tar.gz --directory=/tmp 1>/dev/null || exit 51
    CORL_INSTALL_RUBY="yes"
fi

if [ "$CORL_INSTALL_RUBY" == "yes" ]
then
    cd /tmp/ruby-2.1.2 || exit 52
    ./configure --quiet || exit 53
    make --quiet || exit 54
    make install --quiet || exit 55
fi

if [ ! -e "$HOME/.gemrc" ]
then
# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "$HOME/.gemrc" || exit 56
fi