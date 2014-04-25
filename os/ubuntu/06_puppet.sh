#!/bin/bash
#-------------------------------------------------------------------------------

case "$OS_VERSION" in
'14.04')
    PUPPET_PACKAGE="3.4.3-1"
;;
'12.04')
    PUPPET_PACKAGE="3.4.3-1puppetlabs1"
;;
esac

#---

# Set up Puppet Apt repositories
apt-key adv --recv-key --keyserver pgp.mit.edu 4BD6EC30 2>&1 || exit 60

echo -e "deb http://apt.puppetlabs.com $OS_NAME main dependencies\ndeb-src http://apt.puppetlabs.com $OS_NAME main dependencies" | cat > /etc/apt/sources.list.d/puppet.list || exit 61
chmod 0644 /etc/apt/sources.list.d/puppet.list || exit 62

# Install Puppet
apt-get -y update || exit 63

apt-get -y install puppet-common="$PUPPET_PACKAGE" puppet="$PUPPET_PACKAGE" || exit 64

# Set up Hiera configuration
mkdir -p /var/corl/config || exit 65

( cat <<'EOP'
---
:merge_behavior: deeper
:backends:
  - yaml
  - json
:yaml:
  :datadir: /var/corl/config
:json:
  :datadir: /var/corl/config
:hierarchy:
  - common
EOP
) > /etc/hiera.yaml || exit 66
chmod 0440 /etc/hiera.yaml || exit 67

ln -fs /etc/hiera.yaml /etc/puppet/hiera.yaml || exit 68
