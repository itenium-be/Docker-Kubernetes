# 16 Kubernetes scale and loadbalance

## Follow along

* open <http://demo.itenium-training.be>
* an open Lens

* adjust `kube/demo-backend.yaml` to replicas 3

* watch the "Read-request container history" in the frontend and redeploy the backend

```shell
kubectl apply -f kube/demo-backend.yaml
```
