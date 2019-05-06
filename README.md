This repository contains a setup script doing the initial setup of the [*Windows Subsystem for Linux*](https://de.wikipedia.org/wiki/Windows_Subsystem_for_Linux). After the installtion you will be provided with a functioning Ubuntu installation able to launch applications with a GUI. The windows of the applications running within Ubuntu will seamlessly integrated within your Windows System.

# Usage

1. [Install Ubuntu](https://www.microsoft.com/de-de/p/ubuntu/9nblggh4msv6?rtc=1&activetab=pivot%3Aoverviewtab)
1. [Download the script](https://github.com/jason076/wsl-onboarding/archive/master.zip)
1. *Optional but* **strongly recommended**: This script uses admin permissions, thus the script has the permission to alter your system files. For that reason you should ensure that the files you have downloaded have not been altered.
    1. Open the directory containing the downloaded zip file in the explorer
	1. Hold shift and right click on to the white space next to the listed files
	1. Click on the context menu entry *Start Powershell here*
	1. Enter the following command: `Get-FileHash .\wsl-onboarding-master.zip -Algorithm MD5`
	1. Compare the output hash with this hash: `5A312D012324779E0DFE4D7BECAE9223`
	1. IF THE HASHES DOES NOT MATCH DON'T RUN THE SCRIPT. IT HAS BEEN ALTERED AND IS MAYBE CONTAINING MALICIOUS CODE.
1. Extract the zip archive
1. Open the extracted directory, right click on *run-setup.ps1* and click on *Run with Powershell*

# Work in Progress
This project uses libraries from https://github.com/jason076/script-libs
## Contributing
## Further Reading


