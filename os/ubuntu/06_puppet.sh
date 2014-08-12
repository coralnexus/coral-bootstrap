#!/bin/bash
#-------------------------------------------------------------------------------

PUPPET_PACKAGE="3.6.2-1puppetlabs1"

#---

# Set up Puppet Apt repositories
echo "1. Fetching Puppet keys"
apt-key adv --recv-key --keyserver pgp.mit.edu 4BD6EC30 >/tmp/puppet.key.log 2>&1 || exit 60

echo "2. Updating Puppet packages from source"
echo -e "# corl_puppet\ndeb http://apt.puppetlabs.com $OS_NAME main dependencies\ndeb-src http://apt.puppetlabs.com $OS_NAME main dependencies" | cat > /etc/apt/sources.list.d/corl_puppet.list || exit 61
chmod 0644 /etc/apt/sources.list.d/corl_puppet.list || exit 62

apt-get -y update >/tmp/puppet.update.log 2>&1 || exit 63

# Install Puppet
echo "3. Ensuring Puppet"
apt-get -y install hiera puppet-common="$PUPPET_PACKAGE" puppet="$PUPPET_PACKAGE" >/tmp/puppet.install.log 2>&1 || exit 64

chown -R root:puppet /var/lib/puppet || exit 65

# Set up Hiera configuration
mkdir -p /var/corl/config || exit 66

if [ ! -e /etc/hiera.yaml ]
then
echo "4. Configuring Hiera"
	
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
) > /etc/hiera.yaml || exit 67
chmod 0440 /etc/hiera.yaml || exit 68
fi

if [ ! -e /etc/puppet/hiera.yaml ]
then
    ln -fs /etc/hiera.yaml /etc/puppet/hiera.yaml || exit 69
fi