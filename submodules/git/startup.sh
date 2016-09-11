#! /bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${green}Starting gitlab installation${reset}"

sudo cp -fr docker-compose.yml docker-gitlab
sudo cp -fr jenkins.dockerfile docker-gitlab
#sudo cp -fr elgalu-docker-selenium docker-gitlab


cd docker-gitlab
docker-compose up --build -d 
echo  "${green}##########################################################"
echo  "${green}#  You can surf gitlab under ${yellow} http://localhost:10080 ${green}now "
echo  "${green}##########################################################${reset}"

docker exec -it dockergitlab_jenkins_1 /etc/init.d/jenkins restart

echo  "${green}##########################################################"
echo  "${green}#  You can surf jenkins under ${yellow} http://localhost:8081 ${green}now "
echo  "${green}#  On Windows and Mac http://<docker-machine ip>:8081 ${yellow} http://localhost:8081 ${green}now "
echo  "${green}##########################################################${reset}"


echo  "${green}######################################################################"
echo  "${green}#  You can surf nexus under : ${yellow} http://localhost:8082 ${green}now           "
echo  "${green}#  Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8082 ${green}now "
echo  "${green}######################################################################${reset}"
