#!/usr/bin/env bash

# trap handle_exit 0 SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM
set -o errexit
set -o nounset
set -o pipefail


main() {
	echo "[*] Checking root previlige."
	if [[ $(id -u) -ne 0 ]] ; then echo "$USER does not has sudo previlige. Please run as root" ; exit 1 ; fi


	case "$OSTYPE" in
		ubuntu*)
				echo "[*] OS Detected: $OSTYPE";
				echo "[*] Installing required packages"
				apt-get install apt-transport-https ca-certificates curl software-properties-common;
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
				curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose;
				chmod +x /usr/local/bin/docker-compose;;
		centos*)
				echo "[*] OS Detected: $OSTYPE";
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
				curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
				chmod +x /usr/local/bin/docker-compose;
				docker-compose --version;;
		darwin*)
				echo "[*] OS Detected: $OSTYPE";
				bew install a;
				echo "You are on Mac OSX. Just install docker from docker hub.";;
		*)
				echo "[*] Unknown OS type: $OSTYPE" ;;
	esac
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"