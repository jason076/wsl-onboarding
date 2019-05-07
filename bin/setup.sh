#!/bin/sh

# WSL onboarding script
# Does the initial setup for wsl using VcXsrv as a XServer.
# Install Ubuntu using the windows store and enable WSL in "Windows optional features"
# As an alternative to enable the WSL manually you can start this script with the 
# bundeled powershell script. Consult the README for more information.

# AUTHOR: Jonas Erbe
# GITHUB: https://github.com/jason076
# REPOSITORY: https://github.com/jason076/wsl-onboarding

# throw error if an unset variable is used
set -u

# constants

# Global variables
LANGUAGE="de"
export LANGUAGE


#######################################
# Load language file 
# Globals:
#   LANGUAGE 
# Arguments:
#   none 
# Returns:
#   0: language loaded successfully
#   1: language does not exist
#######################################
load_language() {

  # TODO(jonas): choose language dialog
  
  # load language file
  lang_file=share/language/"${LANGUAGE}".sh
  if [ -f "${lang_file}" ]; then
    . "${lang_file}"
    return 0
  else
    return 1
  fi
}

#######################################
# Install default WSL config files 
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################

install_default_config() {
  # TODO(jason076): Check for errors and return appropriate value
  cp -b ./share/default-config/xinitrc ~/.xinitrc 

  # TODO(jason076): Check Ubuntu standard files and include them
  cp -b ./share/default-config/profile ~/.profile

  # TODO(jason076): Add wsl.conf to message
  sudo cp -b ./share/default-config/wsl.conf /etc/wsl.conf
  
  # binaries
  if [ ! -d ~/.local/bin ]; then
    mkdir -p ~/.local/bin
  fi

  cp -b ./share/default-config/startX.sh ~/.local/bin/startX.sh
}

#######################################
# Create scaleable fonts according to Xming Documentation:
# http://www.straightrunning.com/XmingNotes/fonts.php 
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################

# TODO(jason076): Useless remove in future
create_scalable_fonts() {
  # assuming that 64-bit Xming is installed
  # index fonts for XServer  
  cd "/mnt/c/Program Files/Xming"
  ./mkfontscale.exe 'C:\Windows\Fonts' 2>/dev/null
  ./mkfontscale.exe -b -f -l 'C:\Windows\Fonts' 2>/dev/null
 
  # Add windows fonts to the font dirs of xming
  if grep -i 'C:\\Windows\\Fonts' "/mnt/c/Program Files/Xming/font-dirs"; then
    return 0
  else
    if echo 'C:\Windows\Fonts' >> "/mnt/c/Program Files/Xming/font-dirs"; then
      return 0
    else
      return 1
    fi
  fi

  # TODO(jason076) Add additonal fonts

  # Will be removed
  #if depmgmt__need "fontconfig"; then
    # make fonts available to applications
    #if [ ! -L /usr/local/share/fonts/windows ]; then
    #  sudo ln -s /mnt/c/Windows/Fonts /usr/local/share/fonts/windows
    #fi
    #echo "Indexing fonts may take a while. Please wait ..."
    #fc-cache -rf
  #else
  #  return 1
  #fi
}


main() {
  
  PATH="${PATH}:`pwd`/bin"

  . `pwd`/lib/libmgmt.sh

  # load language
  load_language 
  if [ $? -ne 0 ]; then
    echo "Failed loading language file! Exit!"
    exit 1
  fi

  echo "${WSL_DIALOG}"

  # load script libraries
  libmgmt__load "io"
  libmgmt__load "wsl"
  libmgmt__load "depmgmt"


  io__init 'TRUE' 0 0
  io__message "${WSL_WELCOME}"
  io__message "${WSL_INFO}"

  # upgrade system
  io__message "${WSL_SYS_UPGRADE}"
  sudo apt update
  sudo apt full-upgrade 
  io__message "${WSL_SYS_UPGRADE_FINISHED}"

  # only continue if ubuntu is running in admin mode
  # TODO(jason076): Can be removed since font config was disabled
  #if wsl__is_winadmin; then
  #  :
  #else
  #  io__message "${WSL_NO_ADMIN}" 
  #  exit 1
  #fi

  # install default config files
  io__message "${WSL_INSTALL_CONFIG}"
  install_default_config

  # install VcXsrv
  # TODO(jason076): Change message to VcXsrc
  io__message "${WSL_INSTALL_XMING}"
  ./bin/vcxsrv-installer.exe

  #io__message "${WSL_CREATE_SCALEABLE_FONT}"
  #    
  #if create_scalable_fonts; then
  #  :
  #else
  #  io__message "${WSL_SCALEABLE_FAILED}"
  #  exit 1
  #fi
  
  # TODO(jason076): Add a fix for blurry fonts caused by dpi scaling
  # Dialog for choosing a gdk_scale factor

  # TODO(jason076): Add message
  # Install dbus-x11
  if depmgmt__need dbus-x11; then
    :
  else
    exit 1
  fi

  # Install terminator
  io__message "${WSL_INSTALL_TERMINATOR}"
  if depmgmt__need terminator; then
    :
  else
    io__message "${WSL_INSTALL_TERMINATOR_FAILED}"
    exit 1
  fi

  # TODO(jason076): Add message
  # Install firefox
  if depmgmt__need firefox; then
    :
  else
    exit 1;
  fi

  # Setup succesfull
  io__message "${WSL_SUCCESSFULL}"
  exit 0
}

main "$@"
