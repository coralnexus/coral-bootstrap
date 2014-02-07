#!/bin/bash
#-------------------------------------------------------------------------------

# Set up Puppet Apt repositories
apt-key adv --recv-key --keyserver pgp.mit.edu 4BD6EC30 || exit 60

( cat <<'EOP'
deb http://apt.puppetlabs.com precise main dependencies
deb-src http://apt.puppetlabs.com precise main dependencies
EOP
) > /etc/apt/sources.list.d/coral_puppet.list || exit 61
chmod 0644 /etc/apt/sources.list.d/coral_puppet.list || exit 62

# Install Puppet
apt-get -y update || exit 63
apt-get -y install puppet || exit 64
gem install libshadow || exit 65

# Set up Hiera configuration
mkdir -p /var/coral/config || exit 66

( cat <<'EOP'
---
:merge_behavior: deeper
:backends:
  - yaml
  - json
:yaml:
  :datadir: /var/coral/config
:json:
  :datadir: /var/coral/config
:hierarchy:
  - common
EOP
) > /etc/hiera.yaml || exit 67
chmod 0440 /etc/hiera.yaml || exit 68

cp /etc/hiera.yaml /etc/puppet/hiera.yaml || exit 69