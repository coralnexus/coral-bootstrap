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
configurations) it needs to run the Coral gems and Puppet configuration
management framework.

Systems initialized:

* Git    - Git packages installed

* Ruby   - Ruby 1.9.x packages installed
         - Execution alternative configuration (if applicable)

* Puppet - PuppetLabs Apt source initialized (if applicable)
         - Puppet and dependencies installed
         - Hiera configured

* Coral  - Coral core gem and dependencies installed

--------------------------------------------------------------------------------
Tested under Ubuntu 12.04 LTS
Licensed under GPLv3

See the project page at: http://github.com/coralnexus/coral-bootstrap
Report issues here:      http://github.com/coralnexus/coral-bootstrap/issues
"
fi

if [ -z "$USAGE" ]
then
export USAGE="
usage: bootstrap.sh [ -h | --help ]  | Show usage information
--------------------------------------------------------------------------------
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
  echo "Processing: $SCRIPT"
  source "$SCRIPT"
  STATUS=$?
  
  if [ $STATUS -ne 0 ]
  then
  	exit $STATUS
  fi
done
exit $STATUS
