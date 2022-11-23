# 08 Kubernetes pod

## Follow along

* check out the pods

```shell
kubectl get pods
```

* create a yaml file with pod for the my-app container in `kube/my-app-pod.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app-pod
  labels:
    app: my-app-pod
spec:
  containers:
    - name: my-app-container
      image: devgem/my-app:3.0
      env:
        - name: my_message
          value: "Hello from Itenium on Kubernetes"
      resources:
        limits:
          cpu: 1500m
          memory: 1024Mi
        requests:
          cpu: 50m
          memory: 50Mi
```

* install the pod in kubernetes

```shell
kubectl apply -f kube/my-app-pod.yaml
```

* check out the pods

```shell
kubectl get pods
```

* start the proxy

```shell
kubectl proxy
```

* browse to the the container via the kubectl proxy: <http://localhost:8001/api/v1/namespaces/default/pods/http:my-app-pod:/proxy/>


* change the value of my_message in the pod config

* delete the pod and reinstall it

```shell
kubectl delete -f kube/my-app-pod.yaml
kubectl apply -f kube/my-app-pod.yaml
```
