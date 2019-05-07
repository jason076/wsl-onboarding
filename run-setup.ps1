
Write-Host This Script will request Admin rights, to check if the WSL is enabled and to enable it if it is diabled.
Pause

$cmd_enable_wsl={
    If((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -Match "Enabled"){
        exit 0
    }
    Else{
        Write-Host The Windows-Subsystem-For-Linux is not enabled. It will be enabled now!
        Pause
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
        Write-Host Please Reboot now to install the WSL and restart this setup after the installation has finished.
        Pause
    }
}.ToString()

$bytes = [System.Text.Encoding]::Unicode.GetBytes($cmd_enable_wsl)
$encCmd = [Convert]::ToBase64String($bytes)

start-process -FilePath powershell -Wait -ArgumentList "-encodedCommand $encCmd" –verb runAs


Write-Host The WSL setup process will now be started.
Pause
Ubuntu.exe run bin/setup.sh
Write-Host Ubuntu will launch. You can type `"firefox`" in the terminator terminal to start firefox in Ubuntu. 
Pause
start-process -FilePath Ubuntu.exe

