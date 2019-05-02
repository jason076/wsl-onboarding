# LIBRARY
# Contains common functions for shell scripts

# guard
readonly LIB_COMFUNC='TRUE'

#######################################
# Prints helpmessage and exits 
# Globals:
#   none 
# Arguments:
#   $1: exit code 
#   $1 - $@: Help messages to print
# Returns:
#   none
#######################################

# TODO(jonas): Check if function necessary
comfunc__help_n_exit() {
   com_ret=$1

   shift

   for com_text in "$@";do
       echo $com_text
   done 

   exit $com_ret
}

#######################################
# Tries to link source file to destination.
# Checks if the destination already exist. 
# If this is the case it asks the user, if
# he wants to keep the old file.
# Otherwise it checks if the source exists and
# then links target to source.

# Globals:
#   none 
# Arguments:
#   $1: source
#   $2: destination
# Returns:
#   0: Linking successfull
#   1: Linking failed
#######################################

comfunc__link_file() {
  if [ -e "$2" ]; then
    echo "Destination already exists."
    if comfunc__ask_user "Do you want to overwrite the old link?"; then 
      ln -sf "$1" "$2"
      return 0
    else
      return 1
    fi
    else
      echo "Link for $1 will be created at $2."
      if ln -s "$1" "$2"; then
        return 0
      else
	echo "Linking failed!"
	return 1
      fi
  fi
}

