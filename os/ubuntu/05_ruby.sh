#!/bin/bash
#-------------------------------------------------------------------------------

# Install (root level) RVM.
#
# Some of these commands borrowed from this tutorial:
# http://renaud-cuny.com/en/blog/2013-04-11-step-by-step-ruby-rvm-installation-ubuntu-server
#

function initialize_rvm_user()
{
  local USER_NAME="$1"
  local HOME_BASE="$2"
  
  local LOCAL_HOME="${HOME_BASE}/${USER_NAME}"
  local BASHRC_FILE="${LOCAL_HOME}/.bashrc"
  local PROFILE_FILE="${LOCAL_HOME}/.profile"
  
  local PATH_ENTRY='PATH=${PATH}:/usr/local/rvm/bin'
  local SCRIPT_INCLUDE="[[ -s '/usr/local/rvm/scripts/rvm' ]] && source '/usr/local/rvm/scripts/rvm'"

  echo "4. Initializing RVM user ${USER_NAME} group and environment settings"
  adduser "$USER_NAME" rvm >>/tmp/ruby.config.log 2>&1 || exit 53
  
  if ! grep -Fxq "$PATH_ENTRY" "$PROFILE_FILE" >>/tmp/ruby.config.log 2>&1
  then
    echo "$PATH_ENTRY" >> "$PROFILE_FILE"
  fi
  if ! grep -Fxq "$SCRIPT_INCLUDE" "$BASHRC_FILE" >>/tmp/ruby.config.log 2>&1
  then
    echo "$SCRIPT_INCLUDE" >> "$BASHRC_FILE"
  fi
}

echo "1. Fetching RVM keys"
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 >/tmp/ruby.config.log 2>&1 || exit 50

echo "2. Installing RVM"
curl -sL https://get.rvm.io | bash -s stable >>/tmp/ruby.config.log 2>&1 || exit 51

if [ ! -e "/etc/profile.d/rvmsudo.sh" ]
then
echo "3. Adding a sudoers initialization file (compatible with RVM)"

( cat <<'EOP'
export rvmsudo_secure_path=1
alias sudo=rvmsudo
EOP
) > "/etc/profile.d/rvmsudo.sh" || exit 52
fi

initialize_rvm_user 'root'

for USER_HOME in /home/*/
do
  [[ "$USER_HOME" =~ ([^/]+)/?$ ]]
  if [ "${BASH_REMATCH[1]}" != "lost+found" -a "${BASH_REMATCH[1]}" != "*" ]
  then
    initialize_rvm_user "${BASH_REMATCH[1]}" '/home'
  fi
done

echo "5. Installing Rubinius -- this will take some time"

if [ -z "$RUBY_RVM_VERSION" ]
then
  RUBY_RVM_VERSION='ruby-2.1'
fi

su - -c "rvm install $RUBY_RVM_VERSION" root >>/tmp/ruby.config.log 2>&1 || exit 54
su - -c "rvm use $RUBY_RVM_VERSION --default" root >>/tmp/ruby.config.log 2>&1 || exit 55


if [ ! -e "/root/.gemrc" ]
then
echo "6. Adding an initial .gemrc configuration"

# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "/root/.gemrc" || exit 56
fi