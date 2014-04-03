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

# Install basic build packages.
apt-get -y install build-essential python-software-properties curl || exit 5
