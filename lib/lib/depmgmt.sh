# This library contains functions to check for dependencies needed by other scripts
# and install them if they are missing

# globale variables
LIBMGMT_UPDATED='FALSE'


# TODO(jason076): Add github link
# The library uses the libmgmt script by jason076
# Load libraries
  libmgmt__load io

#######################################
# Checks if the specified binary is installed.
# Globals:
#   none
# Arguments:
#   $1: binary name 
# Returns:
#   0: binary is available 
#   1: binary is not available 
#######################################

depmgmt__chkfor_bin() {
  if type $1 > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

#######################################
# Checks if the specified package is installed. 
# Globals:
#   none
# Arguments:
#   $1: package name 
# Returns:
#   0: package is available 
#   1: package is not available 
#######################################

depmgmt__chkfor_pkg() {
  if apt list --installed 2> /dev/null | grep "$1/" > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

#######################################
# Checks if the specified dependency is installed
# Globals:
#   none
# Options:
#   $1: needed dependency 
# Returns:
#   0: dependency is available 
#   1: dependency is not available 
#######################################

depmgmt__check() {
  if depmgmt__chkfor_bin "$1"; then
    return 0
  elif depmgmt__chkfor_pkg "$1"; then
    return 0;
  else 
    return 1;
  fi
}
 
#######################################
# Tries to install the specified package 
# Globals:
#   LIBMGMT_UPDATED 
# Arguments:
#   $1: package 
# Returns:
#   0: package installed succesfully 
#   1: failed installing the package 
#######################################

depmgmt__install() {
  # TODO(jonas): Use install directory as source to install packages that are not
  # available in standard package sources.
  if [ "${LIBMGMT_UPDATED}" = 'FALSE' ]; then
    echo "Updating package list..."
    sudo apt update
    LIBMGMT_UPDATED='TRUE'
  fi
  try=0
  until depmgmt__check "$1"; do 
    if [ $try -eq 0 ]
    then
      try=1
      io__message "$1 is not available. Try to install it."
      sudo apt install $1 
    else 
      if io__yes_no "Failed to install $1. Do you want to retry?"
      then
          try=0
      else
          return 1 
      fi
    fi
  done

  return 0
}


#######################################
# Checks if the specified dependency is avaiable.  
# If its not available it initiates the installation process. 
# Globals:
#   none
# Options:
#   $1: needed dependency 
# Returns:
#   0: dependency is available 
#   1: dependency is not available 
#######################################
depmgmt__need() {
  if depmgmt__check "$1"; then
    return 0
  elif depmgmt__install "$1"; then
    return 0;
  else 
    return 1;
  fi
}
