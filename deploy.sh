#!/bin/bash

# remove running containers
docker rm -f $(docker ps -qa)


docker network create trio-task-network


docker volume create new-volume

docker build -t trio-task-mysql:5.7 db
docker build -t trio-task-flask-app:latest flask-app

docker run -d \
    --name mysql \
    --network trio-task-network \
    trio-task-mysql:5.7

docker run -d \
    -e MYSQL_ROOT_PASSWORD=password \
    --name flask-app \
    --network trio-task-network \
    trio-task-flask-app:latest

docker run -d \
    --name nginx \
    -p 80:80 \
    --network trio-task-network \
    --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf

echo
docker ps -a