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
  local RVMSUDO_SECURE_PATH="export rvmsudo_secure_path=1"
  local SUDO_ALIAS="alias sudo=rvmsudo"
  
  local SCRIPT_INCLUDE="[[ -s '/usr/local/rvm/scripts/rvm' ]] && source '/usr/local/rvm/scripts/rvm'"

  echo "3. Initializing RVM user ${USER_NAME} group and environment settings"
  adduser "$USER_NAME" rvm >>/tmp/ruby.config.log 2>&1 || exit 52
  
  if ! grep -Fxq "$PATH_ENTRY" "$PROFILE_FILE" >>/tmp/ruby.config.log 2>&1
  then
    echo "$PATH_ENTRY" >> "$PROFILE_FILE"
  fi
  if ! grep -Fxq "$RVMSUDO_SECURE_PATH" "$PROFILE_FILE" >>/tmp/ruby.config.log 2>&1
  then
    echo "$RVMSUDO_SECURE_PATH" >> "$PROFILE_FILE"
  fi
  if ! grep -Fxq "$SUDO_ALIAS" "$PROFILE_FILE" >>/tmp/ruby.config.log 2>&1
  then
    echo "$SUDO_ALIAS" >> "$PROFILE_FILE"
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

initialize_rvm_user 'root'

for USER_HOME in /home/*/
do
  [[ "$USER_HOME" =~ ([^/]+)/?$ ]]
  if [ "${BASH_REMATCH[1]}" != "lost+found" -a "${BASH_REMATCH[1]}" != "*" ]
  then
    initialize_rvm_user "${BASH_REMATCH[1]}" '/home'
  fi
done

echo "4. Installing Rubinius -- this will take some time"
su - -c "rvm install rbx-2.3.0 --rubygems 2.4.2" root >>/tmp/ruby.config.log 2>&1 || exit 53
su - -c "rvm use rbx-2.3.0 --default" root >>/tmp/ruby.config.log 2>&1 || exit 54


if [ ! -e "/root/.gemrc" ]
then
echo "5. Adding an initial .gemrc configuration"

# Set Gem options
( cat <<'EOP'
gem: --no-rdoc --no-ri 
EOP
) > "/root/.gemrc" || exit 55
fi