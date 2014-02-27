#!/bin/bash
#-------------------------------------------------------------------------------

echo "Host name!!!"
echo $HOSTNAME

# Update system packages
apt-get update

# Install basic build packages.
apt-get -y install build-essential || exit 1
