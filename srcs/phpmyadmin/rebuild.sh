#! bin/bash

eval $(minikube docker-env)

docker rmi -f phpmyadmin
docker build . -t phpmyadmin
