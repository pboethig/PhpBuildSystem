#!/usr/bin/env bash

cd /usr/local/jenkins
sh ./startSlave.sh

nohup service apache2 start &
nohup service mysql start &

nohup tail -f /dev/null &
