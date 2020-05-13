#! bin/bash

# Stopping minikube
if [[ $1 == "stop" && $(minikube status | grep -c "Running") != 0 ]]; then
	sh delete.sh
	minikube stop
	unset minikube_ip
	echo "--> minikube has been stoped"
	exit
elif [[ $1 == "stop" ]]; then
	echo "--> minikube is not running"
	exit
fi

# Starting minikube
if [[ $(minikube status | grep -c "Running") == 0 ]]; then 
	minikube start --cpus=2 --memory=4096 --disk-size=8000mb --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=30000-32767
	minikube addons enable metrics-server
	minikube addons enable ingress
	minikube addons enable dashboard
	echo "--> minikube started"
	eval $(minikube docker-env)
	export MINIKUBE_IP=$(minikube ip)
	echo $MINIKUBE_IP
	
	# Building images below : 
	docker build srcs/nginx/. -t nginx-image
	
	# Applying yamls below :
	kubectl create -f srcs/nginx/nginx.yaml
	kubectl apply -f srcs/ingress.yaml
else
	echo "--> minikube is already running at $MINIKUBE_IP"
fi
