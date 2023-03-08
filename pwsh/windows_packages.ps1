
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

refreshenv

choco install virtualbox -y

choco install multipass -y --params="'/HyperVisor:VirtualBox'"

refreshenv

multipass set local.driver=virtualbox

refreshenv
