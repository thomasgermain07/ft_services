#! bin/bash

eval $(minikube docker-env)
docker rmi -f grafana
docker build . -t grafana
