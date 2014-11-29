#!/bin/bash
#-------------------------------------------------------------------------------
#
# bootstrap.sh
#
#-------------------------------------------------------------------------------
# Help

if [ -z "$HELP" ]
then
export HELP="
This script bootstraps a machine with all of the components (packages and 
configurations) it needs to run the CORL system.

Systems initialized:

* Base system - Hostname configured
              - Hosts file initialized (if applicable)
              - DNS configured
              - System package updates
              - Build package installation

* Git         - Git packages installed
              - GitHub added to known hosts

* Editor      - Vim or other base editor packages installed
              - Vim or other base editor configured

* Ruby        - Ruby 2.1.x packages installed
              - Execution alternative configuration (if applicable)
              - Ruby Gem options initialized

* Puppet      - PuppetLabs Apt source initialized (if applicable)
              - Puppet and dependencies installed
              - Hiera configured
         
* Nucleon     - Nucleon gem and dependencies installed

* CORL        - CORL gem and dependencies installed

--------------------------------------------------------------------------------
Tested under Ubuntu 12.04 LTS
Licensed under GPLv3

See the project page at: http://github.com/coralnexus/corl-bootstrap
Report issues here:      http://github.com/coralnexus/corl-bootstrap/issues
"
fi

if [ -z "$USAGE" ]
then
export USAGE="
usage: bootstrap.sh  script_name ...   |  Names of bootstrap scripts to run [ ##_(>>script_name<<).sh ] 
--------------------------------------------------------------------------------
                     [ -h | --help ]   | Show usage information
"
fi

#-------------------------------------------------------------------------------
# Parameters

STATUS=0
SCRIPT_DIR="$(cd "$(dirname "$([ `readlink "$0"` ] && echo "`readlink "$0"`" || echo "$0")")"; pwd -P)"
SHELL_LIB_DIR="$SCRIPT_DIR/lib/shell"

source "$SHELL_LIB_DIR/load.sh" || exit 1

#---

PARAMS=`normalize_params "$@"`

parse_flag '-h|--help' HELP_WANTED

# Standard help message.
if [ "$HELP_WANTED" ]
then
    echo "$HELP"
    echo "$USAGE"
    exit 0
fi
if [ $STATUS -ne 0 ]
then
    echo "$USAGE"
    exit $STATUS    
fi

#-------------------------------------------------------------------------------
# Utilities

BOOTSTRAP_SCRIPTS="$SCRIPT_DIR/os/$OS/*.sh"

#---

for SCRIPT in $BOOTSTRAP_SCRIPTS
do
  SCRIPT_MATCH=''

  if [[ "$SCRIPT" =~ _(.+)\.sh$ ]]
  then
    SCRIPT_NAME="${BASH_REMATCH[1]}"

    if [ ! -z "$PARAMS" ]
    then
      for NAME in ${PARAMS[@]}
      do
        if [[ "$NAME" == "$SCRIPT_NAME" ]]
        then
          SCRIPT_MATCH='1'
        fi
      done
    else
      SCRIPT_MATCH='1'
    fi
  fi

  if [ ! -z "$SCRIPT_MATCH" ]
  then
    echo "Processing: $SCRIPT"
    source "$SCRIPT"
    STATUS=$?
  fi

  if [ $STATUS -ne 0 ]
  then
    exit $STATUS
  fi
done
exit $STATUS