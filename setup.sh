#!/bin/bash

	############################
	# DELCARATION OF VARIABLES #
	############################

MINIKUBE_IP=""

# FONT
BOLD="\e[1m"

# COLORS
MSG="\e[97m" # WHITE
SUCCESS="\e[32m" # GREEN
WARNING="\e[93m" # YELLOW


			############
			# FUNCTION #
			############

printer() {
	HEADER="\e[32mMINIKUBE: $(date +%T) ->\e[0m"
	printf "$HEADER $1$2\n\e[0m"
}

image() {
	eval $(minikube docker-env)
	if [[ $2 == "delete" ]]; then
		printer $MSG "Deleting $1 in the cluster"
		kubectl delete -f srcs/$1/$1.yaml >> .log
		printer $MSG "Deleting image $1"
		docker rmi -f $1 >> .log
	else
		printer $MSG "Building image $1"
		docker build srcs/$1/. -t $1 >> .log
		printer $MSG "Applying $1 in the cluster"
		kubectl apply -f srcs/$1/$1.yaml >> .log
	fi
}

start_minikube() {
	printer $MSG "Starting minikube"
	minikube start --cpus=2 --memory=4096 --disk-size=8000mb --vm-driver=docker --extra-config=apiserver.service-node-port-range=1-35000 &> .log
	minikube addons enable metrics-server >> .log
	minikube addons enable ingress >> .log
	minikube addons enable dashboard >> .log
	MINIKUBE_IP=$(minikube ip)
	printer $SUCCESS "Minikube started with success"
	printer $MSG "Running at: $BOLD$MINIKUBE_IP\n"
}

stop_minikube() {
	printer $MSG "Stopping minikube"
	printer $MSG "Deleting services, deploys, volumes and ingress"
	image influxdb delete
	image mysql delete
	image ftps delete
	image nginx delete
	image phpmyadmin delete
	image wordpress delete
	image grafana delete
	printer $MSG "Deleting ingress in the cluster"
	kubectl delete -f srcs/ingress.yaml >> .log
	printer $MSG "Waiting for all pods to stop"
	kubectl delete pods --all >> .log
	minikube stop 2>&1 >> .log
	printer $MSG "Minikube stopped"
	rm -f .log
	exit
}


	###########################
	# MAIN PART OF THE SCRIPT #
	###########################

if [[ $1 == stop && $(minikube status | grep -c "Running") != 0 ]]; then
	stop_minikube
elif [[ $1 == stop ]]; then
	printer $WARNING "Minikube is not running"
	exit
fi

printer $SUCCESS $BOLD"WELCOME TO FT_SERVICES\n"
if [[ $(minikube status | grep -c "Running") == 0 ]]; then
	start_minikube
else
	MINIKUBE_IP=$(minikube ip)
	printer $WARNING "Minikube is already running at: $BOLD$MSG$MINIKUBE_IP"
fi

# Add minikube_ip to config files
sed -i '40d' srcs/ftps/srcs/vsftpd.conf | echo  "pasv_address=${MINIKUBE_IP}" >> srcs/ftps/srcs/vsftpd.conf
sed "s/ip_minikube/$MINIKUBE_IP/g" srcs/mysql/srcs/.origin.sql > srcs/mysql/srcs/wordpress.sql
sed "s/MINIKUBE/$MINIKUBE_IP/g" srcs/wordpress/srcs/.script_origin.sh > srcs/wordpress/srcs/script.sh

# Builing images
image influxdb
image mysql
image ftps
image nginx
image phpmyadmin
image wordpress
image grafana

sleep 3
echo ""

printer $MSG "Applying ingress in the cluster"
kubectl apply -f srcs/ingress.yaml >> .log

if [[ $(kubectl get ing | grep -c $MINIKUBE_IP) != 1 ]]; then
	while  [ $(kubectl get ing | grep -c $MINIKUBE_IP) != 1 ]
	do
		printer $MSG "Waiting ingress to get ready..."
		sleep 5
	done
fi

echo""

printer $SUCCESS "Everything is good to go !!"
