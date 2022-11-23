# 10 Kubernetes ingress

## Follow along

* check for load balancer in Digital Ocean

* install the nginx ingress controller

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/do/deploy.yaml
```

* recheck for load balancer in Digital Ocean

* get ip-address of the loadbalancer

```shell
kubectl get services --all-namespaces
```

* revert the my-app service back to ClusterIP

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
spec:
  selector:
    app: my-app-pod
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```

```shell
kubectl apply -f kube/my-app-service.yaml
```

* create a yaml file with the ingress for the my-app container in `kube/my-app-ingress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app-ingress
spec:
  rules:
    - host: myapp.itenium-training.be
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: my-app-service
                port:
                  number: 80
  ingressClassName: nginx
```

* open `C:\Windows\System32\drivers\etc\hosts` in Notepad running as Administator
* add lines

```shell
	206.189.243.46       myapp.itenium-training.be
```

* deploy the ingress

```shell
kubectl apply -f kube/my-app-ingress.yaml
```

* goto the exposed app: <http://myapp.itenium-training.be>
