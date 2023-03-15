
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

refreshenv
