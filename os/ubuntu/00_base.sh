#!/bin/bash
#-------------------------------------------------------------------------------

# Set hostname
echo "$HOSTNAME" > "/etc/hostname" || exit 1

sed -ri 's/127\.0\.1\.1.*//' /etc/hosts
echo "127.0.1.1 $HOSTNAME" >> /etc/hosts || exit 2

# Update system packages
apt-get update || exit 3

# Install basic build packages.
apt-get -y install build-essential || exit 4
