eval $(minikube docker-env)

kubectl delete service nginx
kubectl delete service ftps-server
kubectl delete deploy ftps-deploy
kubectl delete deploy nginx
kubectl delete ingress ingress
kubectl delete persistentvolumeclain mysql-claim
kubectl delete service mysql
kubectl delete deploy mysql

docker rmi -f mysql
docker rmi -f nginx-image
docker rmi -f ftps-server
