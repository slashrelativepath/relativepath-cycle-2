# Webserver Environment Setup 

## Windows Setup
Install multipass Hypervisor
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ./windows_packages.ps1
```

## MacOS Setup
This script:
- Checks for Linux or MacOS
- Installs according to OS
- Installs homebrew if MacOS
- Installs multipass using homebrew if MacOS
- Launches an instance named `relativepath` using multipass
- Outputs distro information using `multipass exec`

```
Set script as executable
$ chmod +x macos_packages.sh
Run script
$ bash macos_packages.sh
```
