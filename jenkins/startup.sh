docker-compose up --build -d --force-recreate

echo 'starting jenkins service in container jenkins_jenkins_1'
docker exec -it jenkins_jenkins_mittax_1 /etc/init.d/jenkins restart

echo 'you can surf http://localhost:8081 now'

echo 'On Windows and Mac http://<docker-machine ip>:8081'
