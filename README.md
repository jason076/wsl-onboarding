# WORK IN PROGRESS























This repository contains a setup script doing the initial setup of the [*WindowsSubsyste
# Usage

1. Download the [script](https://github.com/jason076/wsl-onboarding/archive/master.zip)
1. **Recommended**
1. Install [Ubuntu](https://www.microsoft.com/de-de/p/ubuntu/9nblggh4msv6?rtc=1&activetab=pivot%3Aoverviewtab) using the Microsoft store. Wait for the distribution to install, before you continue
1. Enable the Windows Subsystem for Linux
	1. Type "Turn Windows features on or off" ("Windows-Features aktivieren oder Deaktivieren") into the Windows 10 search bar.
	1. Scroll down to "Windows Subsystem for Linux" ("Windows-Subsystem für Linux") and check the box
	1. Click on "ok"
	1. In the next window click "reboot now" ("Jetzt neu starten")
	1. After reboot, search in the Windows 10 search bar for the distribution you have
		 installed in step a). Do a right click on it and click "Run as administrator" ("Als Administrator ausführen")
		 The adminrights are need to install the fonts for the XServer (step c)).
	1. Wait for the install to finish and then type in a username and a passwort. 
		 (You don't see the characters that you type for your passwort.)		
1. Start the setup script
  a) 
# Further reading
## XServer
	Linux needs a XServer to display programs with a GUI. In the case of the Windows Subsystem for Linux
	the XServer is running on your Windows system. Your Linux distro forwars the GUI of the programms running in your linux
	to this XServer. The windows of that programms will be seamlessly integrateted in your Windows Desktop.
	If you realy want to work with your linux distro then I strongly recommend you to install a XServer. 
	I recommend it even if you just want to use terminal applications, because the terminal emulator that is integrated 
	in windows sucks. If you have an XServer installed on windows, then you have the opportunity to install your own terminal 
	emualtor in your linux distro.
