# Webserver Environment Setup 

## Windows Setup
Install multipass Hypervisor
```
run command `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ./windows_packages.ps1`
```

## MacOS Setup
Install homebrew and multipass
```
Set script as executable
$ chmod +x macos_packages.sh
Run script
$ bash macos_packages.sh
```
