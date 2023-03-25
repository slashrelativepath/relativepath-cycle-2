
Function Get-Wifi-Network{
  return multipass networks --format yaml | grep wifi -B 1 | awk -F: 'NR==1{print "$1"}'
}

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
choco -v
$Env:returncode = $?
if ($returncode -eq "False") {
	iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
else {
	echo "choco in already installed"
}	

refreshenv

virtualbox -v
$Env:returncode = $?
if ($returncode -eq "False") { 
	choco install virtualbox -y
}
else {
	echo "Virtual box installed"
}

multipass version
$Env:returncode = $?
if ($returncode -eq "False") {
	choco install multipass -y --params="'/HyperVisor:VirtualBox'"
}
else {
	echo "Multipass is installed"
}

refreshenv

multipass set local.driver=virtualbox
Start-Sleep -Seconds 5
multipass set local.privileged-mounts=1
Start-Sleep -Seconds 5
$network=Get-Wifi-Network
multipass set local.bridged-network=$network
refreshenv
echo "launching relative path instance with Multipass"
multipass launch --name relativepath --bridged

