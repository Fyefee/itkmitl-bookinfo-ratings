kubectl create secret generic registry-bookinfo --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson
kubectl create secret generic bookinfo-uat-ratings-mongodb-secret --from-literal=mongodb-password=CHANGEME --from-literal=mongodb-root-password=CHANGEME
kubectl create configmap bookinfo-uat-ratings-mongodb-initdb --from-file=databases/ratings_data.json --from-file=databases/script.sh
helm install -f k8s/helm-values/values-bookinfo-uat-ratings-mongodb.yaml bookinfo-uat-ratings-mongodb bitnami/mongodb --version 10.28.4
helm install -f k8s/helm-values/values-bookinfo-uat-ratings.yaml bookinfo-uat-ratings k8s/helm