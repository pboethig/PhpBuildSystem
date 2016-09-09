#! /bin/bash

clear
###################################################
# gitlab
cd gitlab-docker
sh ./startup.sh

cd ../

###################################################
# jenkins

cd jenkins
sh ./startup.sh

###################################################
# nexus

cd ../
cd nexus
sh ./startup.sh

###################################################
# selenium
cd ../
cd submodules/selenium/
sh startup.sh


red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo  "${green}######################################################################"
echo  "${green}   You can surf nexus under : ${yellow} http://localhost:8082 ${green}now              "
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8082 ${green}now  "

echo  "                                                                                               "
echo  "${green}   You can surf jenkins under : ${yellow} http://localhost:8081 ${green}now            "
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8081 ${green}now  "

echo  "                                                                                               "
echo  "${green}   You can s gitlab under : ${yellow} http://localhost:8082 ${green}now               "
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8082 ${green}now "
echo  "${green}######################################################################${reset}"
