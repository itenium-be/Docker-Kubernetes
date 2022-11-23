# 09 Kubernetes service

## Follow along

* create a yaml file with the service for the my-app container in `kube/my-app-service.yaml`

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

* check out the services

```shell
kubectl get services
```

* install the service in kubernetes

```shell
kubectl apply -f kube/my-app-service.yaml
```

* check out the services

```shell
kubectl get services
```

* browse to the the container via the kubectl proxy: <http://localhost:8001/api/v1/namespaces/default/services/http:my-app-service:/proxy/>


* change type to NodePort

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
  type: NodePort
```

* redeploy the service in kubernetes

```shell
kubectl apply -f kube/my-app-service.yaml
```

* get the port of the service

```shell
kubectl get services
```

* get ip-address of a node

```shell
kubectl get nodes -o wide
```

* access the service via the ip-address and port on localhost <http://159.223.211.254:31692>
