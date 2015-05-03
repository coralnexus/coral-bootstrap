#!/bin/bash
#-------------------------------------------------------------------------------

if [ ! -f /.dockerinit ]
then
  # Set hostname
  echo "1. Setting hostname"
  echo "$HOSTNAME" > "/etc/hostname" || exit 1

  echo "2. Initializing hosts file"
  sed -ri 's/127\.0\.1\.1.*//' /etc/hosts
  echo "127.0.1.1 $HOSTNAME" >> /etc/hosts || exit 2
fi

# Set OpenDNS as our DNS lookup source
echo "3. Setting command DNS gateways"
echo "nameserver 208.67.222.222" | tee /etc/resolvconf/resolv.conf.d/base > /dev/null || exit 3
resolvconf -u || exit 4

# Update system packages
echo "4. Updating system packages"
apt-get update >/tmp/update.log 2>&1 || exit 5

# Install basic build packages.
echo "5. Ensuring basic libraries and development utilities"
apt-get -y install build-essential cmake rake bindfs libnl-dev libpopt-dev \
                   libssl-dev libcurl4-openssl-dev libxslt-dev libxml2-dev \
                   libyaml-dev libreadline-dev libncurses5-dev zlib1g-dev texinfo \
                   llvm llvm-dev python-software-properties unzip curl bison >/tmp/base.install.log 2>&1 || exit 6
     
