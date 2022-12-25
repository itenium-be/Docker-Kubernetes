# 19a Kubernetes demo in staging

## Solution

* `kube/demo-staging.yaml`

```yaml
# db
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: staging
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
      namespace: staging
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
  namespace: staging
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
---
# backend
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: staging
  name: demo-backend
  labels:
    app: demo-backend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: demo-backend
  template:
    metadata:
      namespace: staging
      labels:
        app: demo-backend
    spec:
      containers:
        - name: demo-backend
          image: jeankedotcom/demo-backend:v1.1
          resources:
            limits:
              cpu: 1500m
              memory: 1024Mi
            requests:
              cpu: 50m
              memory: 50Mi
---
apiVersion: v1
kind: Service
metadata:
  namespace: staging
  labels:
    application: demo-backend
  name: demo-backend
spec:
  selector:
    app: demo-backend
  ports:
    - port: 80
      protocol: TCP
      targetPort: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: staging
  name: demo-backend
spec:
  rules:
    - host: demo-api-staging.itenium-training.be
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: demo-backend
                port:
                  number: 80
  ingressClassName: nginx
---
# frontend
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: staging
  name: demo-frontend
  labels:
    app: demo-frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo-frontend
  template:
    metadata:
      namespace: staging
      labels:
        app: demo-frontend
    spec:
      containers:
        - name: demo-frontend
          image: jeankedotcom/demo-frontend:v2.1
          env:
            - name: REST_API_URL
              value: "http://demo-api-staging.itenium-training.be"
          resources:
            limits:
              cpu: 1500m
              memory: 1024Mi
            requests:
              cpu: 50m
              memory: 50Mi
---
apiVersion: v1
kind: Service
metadata:
  namespace: staging
  labels:
    application: demo-frontend
  name: demo-frontend
spec:
  selector:
    app: demo-frontend
  ports:
    - port: 80
      protocol: TCP
      targetPort: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: staging
  name: demo-frontend
spec:
  rules:
    - host: demo-staging.itenium-training.be
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: demo-frontend
                port:
                  number: 80
  ingressClassName: nginx
```

* add lines to `C:\Windows\System32\drivers\etc\hosts`

```shell
	206.189.243.46       demo-staging.itenium-training.be
	206.189.243.46       demo-api-staging.itenium-training.be
```

* deploy the demo in staging

```shell
kubectl apply -f kube/demo-staging.yaml
```

* check out <http://demo-staging.itenium-training.be/>
