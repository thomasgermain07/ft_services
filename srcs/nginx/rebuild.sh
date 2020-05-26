#! bin/bash

eval $(minikube docker-env)
docker rmi -f nginx
docker build . -t nginx
