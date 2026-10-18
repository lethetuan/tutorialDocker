#!/bin/bash

# Sửa lỗi kiểm tra apt và yum
if [ ! -z "$(which apt 2>/dev/null)" ]; then
	sudo apt -y update	
	sudo apt -y install git wget
elif [ ! -z "$(which yum 2>/dev/null)" ]; then
	sudo yum update -y
	sudo yum install -y wget git
fi

is_ubuntu=$(awk -F '=' '/PRETTY_NAME/ { print $2 }' /etc/os-release | grep -i Ubuntu)
is_centos=$(awk -F '=' '/PRETTY_NAME/ { print $2 }' /etc/os-release | grep -i CentOS)

if [ ! -z "$is_ubuntu" ]; then
	is_docker_exist=$(dpkg -l | grep -i docker)
elif [ ! -z "$is_centos" ]; then
	is_docker_exist=$(rpm -qa | grep docker)
else
	echo "Error: Current Linux release version is not supported, please use either centos or ubuntu."
	exit 1
fi

if [ ! -z "$is_docker_exist" ]; then
	echo "Warning: docker already exists."
fi

# Hàm cài đặt chung cho Docker Compose (Sửa lỗi Regex)
function docker_compose_install()
{
	echo "Installing docker-compose..."
	COMPOSE_VERSION=$(git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oE "[0-9]+\.[0-9]+\.[0-9]+$" | sort --version-sort | tail -n 1)
	sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
}

function ubuntu_install()
{
	sudo apt-get -y update
	sudo apt-get remove -y docker docker-engine docker.io containerd runc
	sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common git vim
	
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
		$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get -y update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io
	
	sudo systemctl enable docker.service
	sudo systemctl start docker
	
	docker_compose_install
	
	is_docker_success=$(sudo docker run hello-world | grep -i "Hello from Docker")
	if [ -z "$is_docker_success" ]; then
		echo "Error: Docker installation Failed."
		exit 1
	fi
	
	echo "Docker and Docker-compose have been installed successfully on Ubuntu."
}

function centos_install()
{
	sudo yum install -y yum-utils device-mapper-persistent-data lvm2 git vim
	sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum -y install docker-ce docker-ce-cli containerd.io
	sudo systemctl enable docker.service
	sudo systemctl start docker
	
	docker_compose_install

	is_docker_success=$(sudo docker run hello-world | grep -i "Hello from Docker")
	if [ -z "$is_docker_success" ]; then
		echo "Error: Docker installation Failed."
		exit 1
	fi

	echo "Docker and Docker-compose have been installed successfully on CentOS."
}

if [ ! -z "$is_ubuntu" ]; then
	ubuntu_install
elif [ ! -z "$is_centos" ]; then
	centos_install
fi

docker-compose --version
