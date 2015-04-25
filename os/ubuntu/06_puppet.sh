#!/bin/bash
#-------------------------------------------------------------------------------

PUPPET_PACKAGE="3.7.5-1puppetlabs1"

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

rm -f /etc/puppet/puppet.conf
rm -f /etc/hiera.yaml

apt-get -y install hiera puppet-common="$PUPPET_PACKAGE" puppet="$PUPPET_PACKAGE" >/tmp/puppet.install.log 2>&1 || exit 64
chown -R root:puppet /var/lib/puppet || exit 65

# Set up Hiera configuration
mkdir -p /var/corl/config || exit 66

echo "4. Configuring Puppet"
( cat <<'EOP'
[main]
  logdir=/var/log/puppet
  vardir=/var/lib/puppet
  ssldir=/var/lib/puppet/ssl
  rundir=/var/run/puppet
  factpath=$vardir/lib/facter
  hiera_config=/etc.hiera.yaml
EOP
) > /etc/puppet/puppet.conf || exit 67


echo "5. Configuring Hiera"
  
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
) > /etc/hiera.yaml || exit 68

chmod 0440 /etc/hiera.yaml || exit 69
