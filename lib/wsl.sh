# This script containts common function to work with Windows Subsystem for Linux (WSL)

# AUTHOR: Jonas Erbe
# GITHUB: https://github.com/jason076
# REPOSITORY: https://github.com/jason076/script-libs

#######################################
# Install WSL utilities (https://github.com/wslutilities/wslu)
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   0: Installation successfull
#   1: Installation failed
#######################################

wsl__install_wslu() {
  if type "wslupath" > /dev/null 2>&1; then
    # wlsu is already installed
    return 0
  else
    # wslu not installed
    libmgmt__load "depmgmt"
    depmgmt__need apt-transport-https
    wget -O - https://api.patrickwu.ml/public.key | sudo apt-key add -

    grep "deb https://apt.patrickwu.ml/ stable main" /etc/apt/sources.list
    if [ $? -ne 0 ]; then
      # add to source liste if source does not exist
      echo "deb https://apt.patrickwu.ml/ stable main" | sudo tee -a /etc/apt/sources.list 
    fi

    sudo apt update
    sudo apt install wslu

    if [ $? -eq 0 ]; then
      return 0
    else
      return 1
    fi
  fi
}

#######################################
# Check if admin rights are available for windows 
# Globals:
#   none 
# Arguments:
# Returns:
#   0: metadata enabled 
#   1: failure 
#######################################

wsl__is_winadmin() {
  # TODO(jason076) Find a fix instead of using this workaround
  # There seems to be a bug in wslupath
  # if [ -w "`wslupath -W`" ]; then
  if [ -w "/mnt/c/Windows" ]; then
    return 0;
  else
    return 1;
  fi
}

#######################################
# Enables the metadata option for the windows filesystem
# More information can be found at:
# https://devblogs.microsoft.com/commandline/chmod-chown-wsl-improvements/
# Globals:
#   none 
# Arguments:
# Returns:
#   0: admin rights available
#   1: no admin rights
#######################################

wsl__enable_fs_meta() {

  # TODO(jason076): The cd fix does not work because the script is maybe running on /mnt/c
  # Find another fix
  if mount | grep '/mnt/c.*metadata'; then
    # metadata already enabled
    return 0
  else
    # change to a directory not located under /mnt/c
    wsl_bck_wd="`pwd`"
    cd /

    # enable metadata
    if sudo umount /mnt/c; then
      if sudo mount -t drvfs C: /mnt/c -o metadata,uid=1000,gid=1000,umask=22,fmask=111; then
        set 0
      else
        set 1
      fi
    else
      set 1
    fi
    # restore working directory
    cd "${wsl_bck_wd}"
    unset "wsl_bck_wd"

    return $1
  fi
}
