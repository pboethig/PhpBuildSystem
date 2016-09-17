#! /bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${green}Starting gitlab installation${reset}"

cp -fr docker-compose.yml docker-gitlab
cp -fr jenkins.dockerfile docker-gitlab
cp -fr php/* docker-gitlab
cp -fr lamp.dockerfile docker-gitlab
cp -fr slave.jar docker-gitlab
cp -fr startSlave.sh docker-gitlab


cd docker-gitlab
docker-compose up --build -d 