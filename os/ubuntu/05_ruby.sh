#!/bin/bash
#-------------------------------------------------------------------------------

# Install Ruby.

CORL_RUBY_BASE="2.1"
CORL_RUBY_PATCH="2"
CORL_RUBY_VERSION="${CORL_RUBY_BASE}.${CORL_RUBY_PATCH}"

if [ ! -f "/tmp/ruby${CORL_RUBY_VERSION}.tar.gz" ]
then
    echo "1. Downloading Ruby tar archive"
    wget "http://ftp.ruby-lang.org/pub/ruby/${CORL_RUBY_BASE}/ruby-${CORL_RUBY_VERSION}.tar.gz" --output-document="/tmp/ruby${CORL_RUBY_VERSION}.tar.gz" -q || exit 50
    CORL_INSTALL_RUBY="yes"
fi
if [ ! -d "/tmp/ruby-${CORL_RUBY_VERSION}" ]
then
    echo "2. Extracting Ruby tar archive"
    tar -xzvf "/tmp/ruby${CORL_RUBY_VERSION}.tar.gz" --directory=/tmp 1>/dev/null || exit 51
    CORL_INSTALL_RUBY="yes"
fi

if [ "$CORL_INSTALL_RUBY" == "yes" ]
then
    cd "/tmp/ruby-${CORL_RUBY_VERSION}" || exit 52
    
    echo "3. Configuring Ruby build"
    ./configure --bindir=/usr/bin >/tmp/ruby.config.log 2>&1 || exit 53
    
    echo "4. Building Ruby"
    make >/tmp/ruby.make.log 2>&1  || exit 54
    
    echo "5. Installing Ruby ${CORL_RUBY_VERSION}"
    make install >/tmp/ruby.install.log 2>&1 || exit 55
    
    echo "6. Installing Bundler"
    gem install bundler >/tmp/bundler.install.log 2>&1 || exit 56
fi

# Install Rubinius.

CORL_RUBINIUS_BASE="2.2"
CORL_RUBINIUS_PATCH="10"
CORL_RUBINIUS_VERSION="${CORL_RUBINIUS_BASE}.${CORL_RUBINIUS_PATCH}"

if [ ! -d "/tmp/rubinius-${CORL_RUBINIUS_VERSION}" ]
then
	echo "7. Fetching Rubinius repository"
    git clone "git://github.com/rubinius/rubinius.git" --branch "v${CORL_RUBINIUS_VERSION}" "/tmp/rubinius-${CORL_RUBINIUS_VERSION}" >/tmp/rubinius.git.log 2>&1 || exit 57
    CORL_INSTALL_RUBY="yes"
fi

if [ "$CORL_INSTALL_RUBY" == "yes" ]
then
    cd "/tmp/rubinius-${CORL_RUBINIUS_VERSION}" || exit 58
    
    echo "8. Ensuring Rubinius dependencies"
    bundle install >/tmp/rubinius.bundle.log 2>&1 || exit 59
    
    echo "9. Configuring Rubinius build"
    ./configure --prefix=/usr/local/rubinius --bindir=/usr/local/bin >/tmp/rubinius.config.log 2>&1 || exit 60
    
    echo "10. Installing Rubinius ${CORL_RUBINIUS_BASE}"
    rake install >/tmp/rubinius.install.log 2>&1 || exit 61
    
    if [ ! -z "$SUDO_USER" ]
    then
    	chown -R $SUDO_USER:$SUDO_USER "$HOME/.rbx" || exit 62
    fi
fi

if [ ! -e "$HOME/.gemrc" ]
then
echo "11. Adding an initial .gemrc configuration"

# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "$HOME/.gemrc" || exit 63
fi