#! /bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${green}Starting gitlab installation${reset}"

sudo cp -fr docker-compose.yml docker-gitlab

cd docker-gitlab
docker-compose up --build -d 
echo  "${green}##########################################################"
echo  "${green}#  You can surf gitlab under ${yellow} http://localhost:10080 ${green}now #"
echo  "${green}##########################################################${reset}"

