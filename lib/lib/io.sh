# Library for io-operations with dialog if available.
# Otherwise it defaults to standard terminal io with echo.

# constants
readonly YES_ALL_VAL_YES=YES
readonly YES_ALL_VAL_NO=NO
readonly IO_PREFIX='\n****BEGIN USER-INTERACTION****'
readonly IO_POSTFIX='*****END USER-INTERACTION*****\n'

# globals
IO_DEFAULT_HEIGHT=0
IO_DEFAULT_WIDTH=0
IO_USE_DIALOG='FALSE'
IO_INITIALIZED='FALSE'

# load libraries

#######################################
# Initializes io 
# Globals:
#   IO_USE_DIALOG
#   IO_HEIGHT
#   IO_WIDTH
# Arguments:
#   $1: use dialog (TRUE or FALSE) 
#   $2: default height
#   $3: default width
# Returns:
#   none
#######################################

io__init() {
  if [ "$1" = "TRUE" ]; then
    libmgmt__load "depmgmt"
    if depmgmt__need "dialog"; then
      IO_USE_DIALOG='TRUE'
    else
      IO_USE_DIALOG='FALSE'
    fi
  else
    IO_USE_DIALOG='FALSE'
  fi

  IO_DEFAULT_HEIGHT="${2:-10}"
  IO_DEFAULT_WIDTH="${3:-20}"
  IO_INITIALIZED='TRUE'
}

#######################################
# Helper function to determine if dialog or
# echo should be used.
# Globals:
#   none 
# Arguments:
#   None
# Returns:
#   0: use dialog
#   1: use echo
#######################################

io__use_dialog() {
  if [ "${IO_USE_DIALOG}" = 'TRUE' ]; then
    return 0
  else
    return 1
  fi
}

#######################################
# Wait for user acknowlagement. 
# Globals:
#   none 
# Arguments:
#   None
# Returns:
#   None 
#######################################

io__wait() {
  echo "Press ENTER to continue!"
  read IO_WAIT_IGONORE
  unset IO_WAIT_IGONORE
}


#######################################
# Print a message and wait for the user to acknowlage
# Globals:
#   none 
# Arguments:
#   $1: text to display 
#   $2: dialog height
#   $3: dialog width
# Returns:
#   none
#######################################

io__message() {
  if [ "${IO_USE_DIALOG}" = 'TRUE' ]; then
    dialog --msgbox "$1" "${2:-"${IO_DEFAULT_HEIGHT}"}" "${3:-"${IO_DEFAULT_WIDTH}"}" 
  else
    echo "${IO_PREFIX}"
    echo "$1"
    io__wait
    echo "${IO_POSTFIX}"
  fi
	
}

#######################################
# Asks user a yes or no question 
# Globals:
#   none
# Arguments:
#   $1: Question 
# Returns:
#   0: yes
#   1: no 
#######################################

io__yes_no() {
  if io__use_dialog; then 
    # TODO(jonas): Implement yesall for dialog
    dialog --yesno "$1" "${2:-"${IO_DEFAULT_HEIGHT}"}" "${3:-"${IO_DEFAULT_WIDTH}"}"
    return $?
  else
    if [ "${YES_ALL:-${YES_ALL_VAL_NO}}" = "${YES_ALL_VAL_NO}" ]; then
      echo "${IO_PREFIX}"
      echo $1
      read io_yn_answer
      case $io_yn_answer in
        y|yes) return 0 ;;
        n|no) return 1 ;;
        *) io__yes_no "Your answer is not valid.k\
          Please type y / yes or n / no and hit enter!"
      esac  
      echo "${IO_POSTFIX}"
    else
        return 0
    fi
  fi
}

#######################################
# Lets the user choose between alternatives. 
# Globals:
#   IFS 
# Arguments:
#   $1: Menu text 
#   $2: Menu height
#   $3: Menu width
#   $4: Menu item height
#   $@: Menu items as strings "tag" "item"
# Returns:
#   0: Valid answer echoed 
#   1: User has aborted 
#######################################

io__menu(){
  if io__use_dialog; then
    menu_text="$1"
    menu_height="$2"
    menu_width="$3"
    menu_item_height="$4"
    shift 4
    # exec 3>&1
    dialog --menu "${menu_text}" "${menu_height}" "${menu_width}" "${menu_item_height}" "$@" 3>&1 1>&2 2>&3
    io_menu_retval=$?
    exec 3>&-
    return ${io_menu_retval}
  else
    exec 3>&1 1>&2 2>&3
    echo "${IO_PREFIX}"

    # print menu message
    echo "$1"

    # ignore size parameter
    shift 4
    io_menu_num_alt=`expr $# / 2`
    io_menu_cnt=1
    io_menu_tags=""

    # print menu options and backup tags seperated by ;
    while [ $io_menu_cnt -le $io_menu_num_alt ]; do
        io_menu_tags="${io_menu_tags};$1" 
      echo "${io_menu_cnt}(${1}): ${2}\n"
      shift 2
      io_menu_cnt=`expr $io_menu_cnt + 1`
    done

    unset io_menu_cnt
    
    # Get answer from user
    io_menu_leave=1
    io_menu_retval=0
    until [ "${io_menu_leave}" -eq 0 ]; do
      echo "Please type a number between 0 and ${io_menu_num_alt} and press enter."
      read io_menu_answer
      if [ "${io_menu_answer}" -gt 0 -a "${io_menu_answer}" -le "${io_menu_num_alt}" ]; then
        # Answer valid, retrieve tag
        BACKIFS="${IFS}"
        IFS=\;
        set $io_menu_tags
        IFS=$BACKIFS
        shift "${io_menu_answer}" 
        io_menu_retval=0
        io_menu_leave=0
        echo "$1" >&3

      elif [ $io_menu_answer -eq 0 ]; then
        # aborted
        io_menu_retval=1
        io_menu_leave=0
        echo "aborted"
      else
        echo "Your answer was not valid."
      fi
    done

    echo "${IO_POSTFIX}"
  
    # Cleanup 
    exec 2>&1 1>&3 3>&-
    unset io_menu_num_alt
    unset io_menu_leave
    unset io_menu_answer
    return $io_menu_retval
  fi
}
