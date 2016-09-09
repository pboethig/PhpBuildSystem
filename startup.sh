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
