# 14 Kubernetes volumes

## Follow along

* create a yaml file for the persistent volume claim in `kube/nginx-pvc.yaml`

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nginx-pvc
spec:
  storageClassName: do-block-storage
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

* create a yaml file for the pod in `kube/nginx-pod.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx-pod
spec:
  containers:
    - name: nginx-container
      image: nginx:1.23.1
      volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: nginx-volume
  volumes:
    - name: nginx-volume
      persistentVolumeClaim:
        claimName: nginx-pvc
```

* check for volumes in Digital Ocean

* deploy the volume

* check for volumes in Digital Ocean

```shell
kubectl apply -f kube/nginx-pvc.yaml
```
* you should see the volume in Lens and in Digital Ocean block storage

```shell
kubectl apply -f kube/nginx-pod.yaml
```

* make sure the proxy is running

```shell
kubectl proxy
```

* browse to the the container via the kubectl proxy: <http://localhost:8001/api/v1/namespaces/default/pods/http:nginx-pod:/proxy/>

* the persistent volume is empty hence the web rootfolder is empty and we get a "403 forbidden" (as nginx does not find the default file `index.html` it reverts to a file listing that is not allowed in the web root folder)

* create an index.html file in `/usr/share/nginx/html`

```shell
cd /usr/share/nginx/html
echo "Hello world from Itenium" > index.html
```

* refresh the browser: <http://localhost:8001/api/v1/namespaces/default/pods/http:nginx-pod:/proxy/>

* you should see `Hello world from Itenium`

* delete the pod

```shell
kubectl delete -f kube/nginx-pod.yaml
```

* refresh the browser: <http://localhost:8001/api/v1/namespaces/default/pods/http:nginx-pod:/proxy/>

* recreate the pod

```shell
kubectl apply -f kube/nginx-pod.yaml
```

* refresh the browser: <http://localhost:8001/api/v1/namespaces/default/pods/http:nginx-pod:/proxy/>

* the custom `index.html` file survived the deletion as it was written in the persistent volume
* that volume was then attatched to the new pod