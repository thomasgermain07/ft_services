#! bin/bash

eval $(minikube docker-env)
docker rmi -f ftps
docker build . -t ftps
