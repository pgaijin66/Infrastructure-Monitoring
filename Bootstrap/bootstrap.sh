#!/usr/bin/env bash

# Defaults
trap handle_exit 0 SIGHUP SIGTERM
set -o errexit
set -o nounset
set -o pipefail

# Trap handling
handle_exit(){
        echo "** Trapped exit event"
}

main() {
        echo "[*] Checking root previlige."
        if [[ $(id -u) -ne 0 ]] ; then echo "$USER does not has sudo previlige. Please run as root" ; exit 1 ; fi

OS_TYPE=$(cat /etc/os-release | awk -F '=' '/^NAME/{print $2}' | awk '{print $1}' | tr -d '"')

# Checking OS TYPE
        case "$OS_TYPE" in
                Ubuntu*)
                                echo "[*] OS Detected: $OS_TYPE";
                                echo "[*] Installing required packages"
                                apt-get install -y apt-transport-https ca-certificates curl software-properties-common;
                                echo "[*] Adding docker GPG key to keystore."
                                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
                                echo "[*] Adding docker to repositories."
                                add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable";
                                echo "[*] Updating installed packages."
                                apt-get update;
                                echo "[*] Installing docker community edition"
                                apt-get -y install docker-ce;
                                echo "[*] Starting docker"
                                systemctl start docker;
                                echo "[*] Adding $USER to docker group"
                                usermod -aG docker ${USER};
                                echo "[*] Installing docker compose"
                                curl -L https://github.com/docker/compose/releases/download/1.27.3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose;
                                chmod +x /usr/local/bin/docker-compose;;
                CentOS*)
                                echo "[*] OS Detected: $OS_TYPE";
                                echo "[*] Installing required packages"
                                yum install -y yum-utils device-mapper-persistent-data lvm2;
                                echo "[*] Updating YUM repo and adding docker repository to repo list."
                                yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo;
                                echo "[*] Installing docker community edition and starting docker service"
                                yum install docker-ce;
                                usermod -aG docker $(whoami);
                                systemctl enable docker.service;
                                systemctl start docker.service;
                                echo "[*] Installing docker compose"
                                yum install epel-release;
                                curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
                                chmod +x /usr/local/bin/docker-compose;
                                docker-compose --version;;
                darwin*)
                                echo "[*] OS Detected: $OS_TYPE";
                                echo "You are on Mac OSX. Just install docker from docker hub.";;
                *)
                                echo "[*] Unknown OS type: $OS_TYPE" ;;
        esac

        echo "[*] Installation complete"
}

# Checking whether this is script was imported or is the entry point.
[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
