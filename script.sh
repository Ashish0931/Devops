#!/bin/bash
############################
#script to deploy a django app  using shell script
############################

code_clone() {

	echo"-------------cloning App from git--------------------"
	git clone https://github.com/LondheShubham153/django-notes-app.git

}


install_prereq() {
	echo "----------installing prerequisites------------"
  	add-apt-repository ppa:deadsnakes/ppa \n
	sudo apt update
	sudo apt install -y Python3.9
	sudo apt install -y nodejs

	sudo apt-get remove docker docker-engine docker.io containerd runc -y

	sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y

	sudo rm -rf /etc/bash_completion.d/docker /usr/local/bin/docker-compose /etc/bash_completion.d/docker-compose -y

	sudo apt install containerd -y

	sudo apt install -y docker.io docker-compose
	sudo apt install nginx 
}
restart_services() {
	echo "---------restarting services------------"
	sudo systemctl enable docker
	sudo systemctl restart nginx
}
deploy() {
	echo "--------deploying code------------"
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}

echo "**************started deployment**********"

if ! code_clone; then
	echo "the code directory already exists."
	cd django-notes-app
fi

if ! install_prereq; then
	echo "***********error with installing prerequisites*********"
	exit 1
fi

if ! restart_services; then
	echo "***********error with restarting services*******"
	exit 2
fi

if ! deploy; then
	echo" ************ error with deployment code. ************"
	exit 3
fi

echo "**********deployment done***********"
