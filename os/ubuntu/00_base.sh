#!/bin/bash
#-------------------------------------------------------------------------------

# Set hostname
echo "$HOSTNAME" > "/etc/hostname" || exit 1

# Update system packages
apt-get update || exit 2

# Install basic build packages.
apt-get -y install build-essential || exit 3
