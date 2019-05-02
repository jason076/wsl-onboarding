# Check if XMing is already running 
XMING_PATH="/mnt/c/Program Files/Xming"

if xset -q > /dev/null 2>&1
then
	echo "Xming is already running."
else
	echo "XMing is not available. Try to start it."
	cd "${XMING_PATH}"
        ./Xming.exe $DISPLAY -multiwindow -clipboard -nolisten inet6 > /dev/null 2>&1 &
  echo "XMing is running in the background now."
fi

. ~/.xinitrc

	

