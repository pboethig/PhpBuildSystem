red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${green}Starting nexus service${reset}"
cd docker-nexus
docker-compose up --build -d 

echo  "${green}######################################################################"
echo  "${green}#  You can surf nexus under : ${yellow} http://localhost:8082 ${green}now           #"
echo  "${green}#  Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:8082 ${green}now #"
echo  "${green}######################################################################${reset}"


