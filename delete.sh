eval $(minikube docker-env)

kubectl delete service nginx
kubectl delete service ftps-server
kubectl delete deploy ftps-deploy
kubectl delete deploy nginx
kubectl delete ingress ingress
kubectl delete persistentvolumeclain mysql-claim
kubectl delete service mysql
kubectl delete deploy mysql
kubectl delete service wordpress
kubectl delete deploy wordpress
kubectl delete service phpmyadmin
kubectl delete deploy phpmyadmin

docker rmi -f mysql
docker rmi -f nginx-image
docker rmi -f ftps-server
docker rmi -f wordpress
docker rmi -f phpmyadmin
