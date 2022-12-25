# 11a Kubernetes multi api resource

## Solution

* create a yaml file with the your-app in `kube/your-app.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: your-app-pod
  labels:
    app: your-app-pod
spec:
  containers:
    - name: your-app-container
      image: devgem/my-app:3.0
      env:
        - name: my_message
          value: "Hello from yourapp on Kubernetes"
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
  name: your-app-ingress
spec:
  rules:
    - host: yourapp.itenium-training.be
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
	206.189.243.46       yourapp.itenium-training.be
```

* deploy yourapp

```shell
kubectl apply -f kube/your-app.yaml
```

* goto the exposed app: <http://yourapp.itenium-training.be>