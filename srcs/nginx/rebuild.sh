#! bin/bash

eval $(minikube docker-env)
docker rmi -f nginx-image
docker build . -t nginx-image
