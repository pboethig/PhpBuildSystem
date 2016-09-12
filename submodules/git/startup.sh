#! /bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${green}Starting gitlab installation${reset}"

sudo cp -fr docker-compose.yml docker-gitlab
sudo cp -fr jenkins.dockerfile docker-gitlab

cd docker-gitlab
docker-compose up --build -d 

docker exec -it dockergitlab_jenkins_1 /var/lib/jenkins/startup.sh
