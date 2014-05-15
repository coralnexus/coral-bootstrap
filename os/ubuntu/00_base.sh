#!/bin/bash
#-------------------------------------------------------------------------------

# Set hostname
echo "$HOSTNAME" > "/etc/hostname" || exit 1

sed -ri 's/127\.0\.1\.1.*//' /etc/hosts
echo "127.0.1.1 $HOSTNAME" >> /etc/hosts || exit 2

# Set OpenDNS as our DNS lookup source
echo "nameserver 208.67.222.222" | tee /etc/resolvconf/resolv.conf.d/base > /dev/null || exit 3

# Update system packages
apt-get update || exit 4
apt-get -y dist-upgrade || exit 5

# Install basic build packages.
apt-get -y install build-essential bindfs libnl-dev libpopt-dev libssl-dev libcurl4-openssl-dev libxslt-dev libxml2-dev || exit 6
apt-get -y install python-software-properties unzip curl || exit 7
