#!/bin/bash
docker run -d -p 5000:5000 --restart=always --name registry registry:2

docker tag task6-artifact:latest localhost:5000/task6-artifact:latest

docker push localhost:5000/task6-artifact:latest

docker rmi localhost:5000/task6-artifact:latest
docker rmi task6-artifact:latest

docker pull localhost:5000/task6-artifact:latest

docker run -d --name task6-app localhost:5000/task6-artifact:latest

echo "Docker Registry EXTRA task completed"


