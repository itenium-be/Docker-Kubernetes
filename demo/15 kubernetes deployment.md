# 15 Kubernetes deployment

## Follow along

* we are going to reuse the demo application for execise "5a multiple docker containers"

* create a yaml for the demo namespace in `kube/demo-namespace.yaml`

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: demo
```

* deploy the namespace

```shell
kubectl apply -f kube/demo-namespace.yaml
```

* create a yaml for the deployment of the mongo database in `kube/demo-db.yaml` (no need for persistence) including a service that exposes the database via `demo-db-mongodb`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: demo
  name: demo-db-mongodb
  labels:
    app: demo-db-mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo-db-mongodb
  template:
    metadata:
      namespace: demo
      labels:
        app: demo-db-mongodb
    spec:
      containers:
        - name: demo-db-mongodb
          image: mongo:latest
---
apiVersion: v1
kind: Service
metadata:
  namespace: demo
  labels:
    application: demo-db-mongodb
  name: demo-db-mongodb
spec:
  selector:
    app: demo-db-mongodb
  ports:
    - port: 27017
      protocol: TCP
      targetPort: 27017
```

* deploy the database

```shell
kubectl apply -f kube/demo-db.yaml
```

## Exercise

* create a yaml file for the backend in `kube/demo-backend.yaml` with
  * a deployment
    * in namespace `demo`
    * named `demo-backend`
    * from the image `jeankedotcom/demo-backend:v1.1`
    * with resource requests of 50m cpu and 50Mi memory
    * with resource limits of 1500m cpu and 1024Mi memory
  * a service to get to the pod
    * in namespace `demo`
    * named `demo-backend`
    * that exposes port 80 and forwards to targetPort 80 on the pod
  * an ingress to link to the service
    * in namespace `demo`
    * named `demo-backend`
    * that links to hostheader `demo-api.itenium-training.be`

* add `demo-api.itenium-training.be` to the hosts file

* deploy the backend

* check if it works
  * by accessing <http://localhost:8001/api/v1/namespaces/demo/services/http:demo-backend:/proxy/> if `kubectl proxy` is running (you will get an error about swagger.json but that's no problem)
  * by accessing <http://demo-api.itenium-training.be>
  
* create a yaml file for the frontend in `kube/demo-frontend.yaml` with
  * a deployment
    * in namespace `demo`
    * named `demo-frontend`
    * from the image `jeankedotcom/demo-frontend:v2.1`
    * with resource requests of 50m cpu and 50Mi memory
    * with resource limits of 1500m cpu and 1024Mi memory
    * with an environment variable named REST_API_URL with value `http://demo-api.itenium-training.be`
  * a service to get to the pod
    * in namespace `demo`
    * named `demo-frontend`
    * that exposes port 80 and forwards to targetPort 80 on the pod
  * an ingress to link to the service
    * in namespace `demo`
    * named `demo-frontend`
    * that links to hostheader `demo.itenium-training.be`

* add `demo.itenium-training.be` to the hosts file

* deploy the frontend

* check if it works
  * by accessing <http://localhost:8001/api/v1/namespaces/demo/services/http:demo-frontend:/proxy/> if `kubectl proxy` is running
  * by accessing <http://demo.itenium-training.be>
