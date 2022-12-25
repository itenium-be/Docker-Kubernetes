# 15a Kubernetes deployment

## Solution

* `kube/demo-backend.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: demo
  name: demo-backend
  labels:
    app: demo-backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo-backend
  template:
    metadata:
      namespace: demo
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
  namespace: demo
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
  namespace: demo
  name: demo-backend
spec:
  rules:
    - host: demo-api.itenium-training.be
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
```

* deploy the backend

```shell
kubectl apply -f kube/demo-backend.yaml
```

* add lines to `C:\Windows\System32\drivers\etc\hosts`

```shell
	206.189.243.46       demo-api.itenium-training.be
```

* <http://demo-api.itenium-training.be>

* `kube/demo-frontend.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: demo
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
      namespace: demo
      labels:
        app: demo-frontend
    spec:
      containers:
        - name: demo-frontend
          image: jeankedotcom/demo-frontend:v2.1
          env:
            - name: REST_API_URL
              value: "http://demo-api.itenium-training.be"
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
  namespace: demo
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
  namespace: demo
  name: demo-frontend
spec:
  rules:
    - host: demo.itenium-training.be
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

* deploy the frontend

```shell
kubectl apply -f kube/demo-frontend.yaml
```

* add lines to `C:\Windows\System32\drivers\etc\hosts`

```shell
	206.189.243.46       demo.itenium-training.be
```

* <http://demo.itenium-training.be>
