#! bin/bash

eval $(minikube docker-env)
docker rmi -f influxdb
docker build . -t influxdb
