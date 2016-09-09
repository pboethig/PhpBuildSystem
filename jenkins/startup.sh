docker-compose up --build -d 

echo 'On Windows and Mac http://<docker-machine ip>:8081'

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${green}Starting jenkins service in container jenkins_jenkins_1${reset}"

docker-compose up --build -d 
echo  "${green}######################################################################"
echo  "${green}#  You can surf jenkins under : ${yellow} http://localhost:8081 ${green}now           #"
echo  "${green}#  Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8081 ${green}now #"
echo  "${green}######################################################################${reset}"

docker exec -it jenkins_jenkins_1 /var/lib/jenkins/startup.sh
