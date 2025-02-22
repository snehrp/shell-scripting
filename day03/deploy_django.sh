#!/bin/bash

<< task
This shell-script can deploy the code from the github
Also it contains the error handling
task

clone_code() {
	echo "Cloning the Github repo"
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

installing_requirements() {
	echo "Installing the requirements"
	sudo apt-get update
	sudo apt-get install docker.io nginx -y docker-compose
}

required_restarts() {
	sudo chown $USER /var/run/docker.sock
	# sudo systemctl enable docker
	# sudo systemctl enable nginx
	# sudo systemctl restart docker
}

deploy() {
	docker build -t notes-app .
	# docker run -d -p 8000:8000 notes-app:latest
	docker-compose up -d
}

echo "Deployment Started"
if ! clone_code; then
	echo "Code directory already exist"
	cd django-notes-app
fi
if ! installing_requirements; then
	echo "Error while installing the dependencies"
	exit 1
fi
if ! required_restarts; then
	echo "Error while restarting"
	exit 1
fi
if ! deploy; then
	echo "Error while deploying the app"
	# sendmail
	exit 1
fi

echo "Deployment done"
