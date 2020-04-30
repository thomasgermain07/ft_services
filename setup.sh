#! bin/bash

# Stopping minikube
if [[ $1 == "stop" && $(minikube status | grep -c "Running") != 0 ]]; then
	sh delete.sh
	minikube stop
	echo "--> minikube has been stoped"
	exit
elif [[ $1 == "stop" ]]; then
	echo "--> minikube is not running"
	exit
fi

# Starting minikube
if [[ $(minikube status | grep -c "Running") == 0 ]]; then 
	minikube start --cpus=2 --memory=4096 --disk-size=8000mb --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000
	minikube addons enable metrics-server
	minikube addons enable ingress
	minikube addons enable dashboard
	echo "--> minikube started"
	eval $(minikube docker-env)
	docker build srcs/nginx/. -t nginx-image
	kubectl create -f srcs/nginx/nginx.yaml
else
	echo "--> minikube is already running"
fi

# Store the Ip address
ip=$(minikube ip)
