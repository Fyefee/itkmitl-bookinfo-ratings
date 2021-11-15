kubectl create secret generic registry-bookinfo --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson
kubectl create secret generic bookinfo-prd-ratings-mongodb-secret --from-literal=mongodb-password=CHANGEME --from-literal=mongodb-root-password=CHANGEME
kubectl create configmap bookinfo-prd-ratings-mongodb-initdb --from-file=databases/ratings_data.json --from-file=databases/script.sh
helm install -f k8s/helm-values/values-bookinfo-prd-ratings-mongodb.yaml bookinfo-prd-ratings-mongodb bitnami/mongodb --version 10.28.4
helm install -f k8s/helm-values/values-bookinfo-prd-ratings.yaml bookinfo-prd-ratings k8s/helm