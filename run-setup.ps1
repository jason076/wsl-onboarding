
Write-Host This Script will request Admin rights, to enable the WSL and to install the XServer.
Pause

$cmd1="Set-Location $PWD
"
$cmd2={
    Write-Host Check if the WSL is enabled...
    If((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -Match "Enabled"){
        Write-Host The WSL is enabled!
        Write-Host The WSL setup process will now be started.
        Pause
        Ubuntu.exe run bin/setup.sh
    }
    Else{
        Write-Host The Windows-Subsystem-For-Linux is not enabled. It will be enabled now!
        Pause
        Write-Host Please reboot after WSL has been enabled and restart this setup script!
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
        Write-Host Please Reboot now to install the WSL and restart this setup after the installation has finished.
        Pause
    }
}.ToString()

$bytes = [System.Text.Encoding]::Unicode.GetBytes($cmd1 + $cmd2)
$encCmd = [Convert]::ToBase64String($bytes)
$wd=Get-Location
start-process -FilePath powershell -Wait -ArgumentList "-encodedCommand $encCmd" –verb runAs

Write-Host Ubuntu will launch. You can type `"firefox`" in the terminator terminal to start firefox in Ubuntu. 
Pause
start-process -FilePath Ubuntu.exe

