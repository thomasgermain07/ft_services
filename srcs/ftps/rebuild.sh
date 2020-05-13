#! bin/bash

eval $(minikube docker-env)
docker rmi -f ftps-server
docker build . -t ftps-server
