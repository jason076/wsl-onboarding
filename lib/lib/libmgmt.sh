# This library contains functions to make using
# posix compatible script libraries more pleasant. 

#######################################
# Loads a script library and verifies that the library is not loaded again, 
# if it is already available. Libraries can safely cross depend on each
# other. For that purpose this function derives a global variable from
# the library name. The variable is named "LIB_<library_name>". 
# <library_name> will be substituted by the name of the library passed
# as the first argument.
# Globals:
#  LIB_<library_name> (dynamic) 
# Arguments:
#   $1: library name 
# Returns:
#   0: library loaded successfully
#   1: library not found
#######################################

libmgmt__load() {
  # TODO(jason076): Make it possible to pass an library path as the second
  # argument of function. 
  # build the dynamic variable name
  libloader_libguard="LIB_`echo "$1" | tr [a-z] [A-Z]`"
  
  # builds a variable with the name contained in libloader_libguard
  # and then checks if it is already set
  if [ "`eval 'echo ${'${libloader_libguard}':=""}'`" = '' ]; then
    # library not loaded
    libloader_libname=${1}.sh
    libloader_libpath=""

    if [ -f ${libloader_libname} ]; then
      libloader_libpath="./${libloader_libname}"
    elif [ -f lib/$libloader_libname ]; then
      libloader_libpath=lib/${libloader_libname}
    # TODO(jason076): Search up the directory hierachy with a while loop
    elif [ -f ../lib/$libloader_libname ]; then
      libloader_libpath=../lib/$libloader_libname
    elif [ -f ~/.local/lib/$libloader_libname ]; then
      libloader_libpath=~/.local/lib/$libloader_libname
    elif [ -f /usr/local/lib/$libloader_libname ]; then
      libloader_libpath=/usr/local/lib/$libloader_libname
    fi

    if [ -n "${libloader_libpath}" ]; then
      eval "${libloader_libguard}=TRUE"
      eval "export ${libloader_libguard}"
      . $libloader_libpath
      unset libloader_libguard
      return 0
    else
      echo "Library \"$1\" not found in \"$0\"!"
      unset libloader_libguard
      return 1
    fi
  fi
}
