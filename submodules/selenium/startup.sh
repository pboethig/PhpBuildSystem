red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`

echo "${green}Starting selenium service${reset}"
cd elgalu-docker-selenium/
docker-compose --file docker-compose-host.yml up --build -d 


docker run -d --name=grid -p 4444:24444 -p 5900:25900 \
    -e TZ="US/Pacific" -v /dev/shm:/dev/shm elgalu/selenium


docker exec grid wait_all_done 30s


echo  "${green}######################################################################"
echo  "${green}#  You can reach selenium gui under : ${yellow} http://localhost:4444/grid/console ${green}now"
echo ""
echo  "${green}#  You can reach selenium gui under : ${yellow} http://localhost:4444/grid/console ${green}now"

echo "Selenium Hub Url: http://localhost:4444/wd/hub"
echo "Selenium Hub Url: http://<docker-machine-ip>:4444/wd/hub"

echo ""
echo  "${green}#  Windows / Mac Users can use: ${yellow} http://<docker-machine-ip>:444/grid/console ${green}now #"
echo  "${green}######################################################################${reset}"
