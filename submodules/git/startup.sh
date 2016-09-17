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
echo  "${green}##########################################################################################"
echo  "${green}waiting for jenkins to start slaves : ${reset}              "

while ! curl http://localhost:8081/ >>/dev/null
do
  echo "$(date) - still trying"
  sleep 1
done
echo "$(date) - connected successfully"
echo  "${green}##########################################################################################"
echo  "${green}start jenkins slaves : ${reset}              "

docker exec -it dockergitlab_webserver_1 /run_slave.sh


echo  "${green}##########################################################################################"
echo  "${yellow}Summary:"
echo  "${green}##########################################################################################"
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
echo  "${green}   Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:444/grid/console ${green}now "

echo  "${green}##########################################################################################${reset}"


