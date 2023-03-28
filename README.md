# Relative Path Cycle 2

The goal of this repository is to keep track of the files and documentation for the following outcomes:

  * build an ubuntu jammy (22.04) virtual machine
  * install NGINX webserver on the virtual machine
  * verify webserver is functioning using curl or browswer

## TODO

- [ ] Add install conditional to MacOS
- [x] Remove `multipass exec` commands from webserver.sh
- [x] Check host machine for ssh keys
- [x] If keys exist, do nothing; if keys do not exist, create an ssh key
- [ ] Add keys to cloud-init.yaml file
- [ ] Launch, using multipass, an instance with that cloud-init.yaml
- [ ] SSH to the VM
- [ ] Continue with the installation

## Usage

### Windows Setup

Install multipass Hypervisor

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ./windows_packages.ps1
```

### MacOS & Linux Setup

This script:

- Checks for Linux or MacOS
- Installs according to OS
- Installs homebrew if MacOS or apt and snapd if Linux
- Installs multipass
- Check host machine for ssh keys
- If keys exist, do nothing; if keys do not exist, create an ssh key
- Launches an instance named `relativepath` using multipass
- Outputs distro information using `multipass exec`
- apt update
- installs nginx
- restarts nginx

Run script

```shell
bash webserver.sh
```
