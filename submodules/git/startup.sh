#! /bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${green}Starting gitlab installation${reset}"

sudo cp -fr docker-compose.yml docker-gitlab
sudo cp -fr jenkins.dockerfile docker-gitlab
sudo cp -fr lamp.dockerfile docker-gitlab
sudo cp -fr run_lamp.sh docker-gitlab
sudo cp -fr webslave docker-gitlab


cd docker-gitlab
docker-compose up --build -d 

# start jenkins
docker exec -it dockergitlab_jenkins_1 /var/lib/jenkins/startup.sh


# start jenkins slave

echo "${green}Startink jenkins slave dockergitlab_webserver_1 /usr/local/jenkins/startSlave.sh  ${reset}"
docker exec -it  dockergitlab_webserver_1 /usr/local/jenkins/startSlave.sh


#start apache / mysql
docker exec -it  dockergitlab_webserver_1 /run_lamp.sh

