# Bookinfo Rating Service

Rating service has been developed on NodeJS

## License

MIT License

## How to run

```bash
node ratings.js 8080
```

## How to run with Docker Compose

```bash
docker-compose up
```

## How to run with Docker

```bash
# Build Docker Image for rating service
docker build -t ratings .

# Run MongoDB with initial data in database
docker run -d --name mongodb -p 27017:27017 \
  -v $(pwd)/databases:/docker-entrypoint-initdb.d bitnami/mongodb:5.0.2-debian-10-r2

# Run ratings service on port 8080
docker run -d --name ratings -p 8080:8080 --link mongodb:mongodb \
  -e SERVICE_VERSION=v2 -e 'MONGO_DB_URL=mongodb://mongodb:27017/ratings' ratings
```

## How to run with Kubernetes

```bash
# Create namespace & Set default working namespace

# Create Kubernetes imagePullSecrets
kubectl create secret generic registry-bookinfo \
  --from-file=.dockerconfigjson=$HOME/.docker/config.json \
  --type=kubernetes.io/dockerconfigjson

# Create Kubernetes Secret for MongoDB password
helm install mongodb bitnami/mongodb --set persistence.enabled=false
export MONGODB_ROOT_PASSWORD=$(kubectl get secret mongodb \
  -o jsonpath="{.data.mongodb-root-password}" | base64 --decode)
kubectl create secret generic bookinfo-dev-ratings-mongodb-secret \
  --from-literal=mongodb-password=CHANGEME \
  --from-literal=mongodb-root-password=CHANGEME

# Create Kubernetes ConfigMap for MongoDB initial database script
kubectl create configmap bookinfo-dev-ratings-mongodb-initdb \
  --from-file=databases/ratings_data.json \
  --from-file=databases/script.sh

# Deploy MongoDB with Helm to be ready for Rating Service
helm uninstall mongodb
helm install -f k8s/helm-values/values-bookinfo-dev-ratings-mongodb.yaml \
  bookinfo-dev-ratings-mongodb bitnami/mongodb --version 10.28.4

# Deploy Ratings Helm Chart
helm install bookinfo-dev-ratings k8s/helm
```

```bash
# Testing
curl http://itkmitl.bookinfo.dev.opsta.net/student19/ratings/health
curl http://itkmitl.bookinfo.dev.opsta.net/student19/ratings/ratings/1
```

## Website

[Opsta (Thailand) Co., Ltd.](https://www.opsta.co.th)
