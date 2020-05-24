#! bin/bash

eval $(minikube docker-env)
docker rmi -f mysql
docker build -t mysql .
