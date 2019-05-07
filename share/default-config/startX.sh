# Check if XMing is already running 
XSERVER_PATH="/mnt/c/Program Files/VcXsrv"
set -x
if xset -q > /dev/null 2>&1
then
  echo "XServer is already running."
else
  echo "XServer is not available. Try to start it."
  cd "${XSERVER_PATH}"
        ./vcxsrv.exe `echo $DISPLAY | grep -o :[0-9]` -wgl -multiwindow -clipboard -nolisten inet6 > /dev/null 2>&1 &                             
fi

. ~/.xinitrc
