
echo 'startup gitlab'

docker-compose up --build -d --force-recreate

echo 'you can surf http://localhost:10080 now'
