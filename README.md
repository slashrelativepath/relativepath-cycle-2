# Webserver Environment Setup 

## Windows Setup
Install multipass Hypervisor
```
run command `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ./windows_packages.ps1`
```

## MacOS Setup
This script:
- Installs homebrew
- Installs multipass using homebrew
- Launches an instance named `relativepath` using multipass
- Outputs distro information using `multipass exec`

```
Set script as executable
$ chmod +x macos_packages.sh
Run script
$ bash macos_packages.sh
```
