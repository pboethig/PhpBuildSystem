#! /bin/bash

clear
###################################################
# gitlab
cd submodules/git/
sudo sh ./startup.sh


###################################################
# nexus
cd ../
cd nexus

sudo rm -rf docker-nexus/docker-compose.yml
sudo cp -fr docker-compose.yml docker-nexus
sudo chmod a+x startup.sh
sudo sh ./startup.sh


###################################################
# jenkins

cd ../
cd jenkins/docker-jenkins

sudo chmod a+x startup.sh
sudo sh ./startup.sh

##################################################
# selenium
cd ../
cd selenium/

sudo chmod a+x startup.sh
sudo sh startup.sh

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo  "${yellow}Summary:"
echo  "${green}######################################################################"
echo  "${green}   You can surf gitlab under : ${yellow} http://localhost:10080 ${green}now              "
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:10080 ${green}now  "

echo  "                                                                                               "
echo  "${green}   You can surf jenkins under : ${yellow} http://localhost:8081 ${green}now            "
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8081 ${green}now  "

echo  "                                                                                               "
echo  "${green}   You can surf nexus under : ${yellow} http://localhost:8082 ${green}now               "
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8082 ${green}now "

echo  ""
echo  "${green}   You can use selenium under : ${yellow} http://localhost:8083 ${green}now               "
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8083 ${green}now "


echo  "${green}   You can reach selenium gui under : ${yellow} http://localhost:4444/grid/console ${green}now"
echo  ""
echo  "${green}   You can reach selenium gui under : ${yellow} http://localhost:4444/grid/console ${green}now"

echo  "${green}   Selenium Hub Url: http://localhost:4444/wd/hub"
echo  "${green}   Selenium Hub Url: http://<docker-machine-ip>:4444/wd/hub"

echo  ""
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:444/grid/console ${green}now #"

echo  "${green}######################################################################${reset}"
