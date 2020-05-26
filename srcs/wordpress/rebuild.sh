#! bin/bash

eval $(minikube docker-env)

docker rmi -f wordpress
docker build . -t wordpress
