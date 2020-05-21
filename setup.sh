# Stopping minikube
if [[ $1 == "stop" && $(minikube status | grep -c "Running") != 0 ]]; then
	sh delete.sh
	minikube stop
	unset MINIKUBE_IP
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
else
	echo "--> minikube is already running at $MINIKUBE_IP"
fi
	eval $(minikube docker-env)
	export MINIKUBE_IP=$(minikube ip)
	echo $MINIKUBE_IP

	#add minikube_ip to config files
	echo "pasv_address=$MINIKUBE_IP" >> srcs/ftps/srcs/vsftpd.conf

	# Building images below :
	docker build srcs/nginx/. -t nginx-image
	docker build srcs/ftps/. -t ftps-server

	# Applying yamls below :
	kubectl create -f srcs/nginx/nginx.yaml
	kubectl apply -f srcs/ftps/ftps.yaml
	kubectl apply -f srcs/ingress.yaml
