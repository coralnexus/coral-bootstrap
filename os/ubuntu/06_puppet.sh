#!/bin/bash
#-------------------------------------------------------------------------------

# Set up Puppet Apt repositories
apt-key adv --recv-key --keyserver pgp.mit.edu 4BD6EC30

( cat <<'EOP'
deb http://apt.puppetlabs.com precise main dependencies
deb-src http://apt.puppetlabs.com precise main dependencies
EOP
) > /etc/apt/sources.list.d/coral_puppet.list
chmod 0644 /etc/apt/sources.list.d/coral_puppet.list

# Install Puppet
apt-get -y update
apt-get -y install puppet
gem install -y libshadow

# Set up Hiera configuration
mkdir /var/hiera

( cat <<'EOP'
---
:merge_behavior: deeper
:backends:
  - yaml
  - json
:yaml:
  :datadir: /var/hiera
:json:
  :datadir: /var/hiera
:hierarchy:
  - common
EOP
) > /etc/puppet/hiera.yaml
chmod 0440 /etc/puppet/hiera.yaml
