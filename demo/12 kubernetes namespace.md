# 12 Kubernetes namespace

## Follow along

* create a yaml file for the staging namespace in `kube/staging-namespace.yaml`

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: staging
```

* deploy the namespace

```shell
kubectl apply -f kube/staging-namespace.yaml
```

* create a yaml file with the your-app in the staging namespace and with a different message in `kube/your-app-staging.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  namespace: staging
  name: your-app-pod
  labels:
    app: your-app-pod
spec:
  containers:
    - name: your-app-container
      image: devgem/my-app:3.0
      env:
        - name: my_message
          value: "Hello from yourapp in staging on Kubernetes"
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
  name: your-app-service
spec:
  selector:
    app: your-app-pod
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: staging
  name: your-app-ingress
spec:
  rules:
    - host: yourapp-staging.itenium-training.be
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: your-app-service
                port:
                  number: 80
  ingressClassName: nginx
```

* open `C:\Windows\System32\drivers\etc\hosts` in Notepad running as Administator
* add lines

```shell
	206.189.243.46       yourapp-staging.itenium-training.be
```

* deploy the yourapp in the staging namespace

```shell
kubectl apply -f kube/your-app-staging.yaml
```

* goto the exposed app: <http://yourapp-staging.itenium-training.be>
