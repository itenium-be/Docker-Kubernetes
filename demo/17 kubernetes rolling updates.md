# 17 Kubernetes rolling updates

## Follow along

* open <http://demo.itenium-training.be>
* and open Lens

* adjust `kube/demo-backend.yaml` to v1.2

* checkout the current deployment

```shell
kubectl describe deployment --namespace demo demo-backend
```

* redeploy the backend and watch the rollout happen while looking at <http://demo.itenium-training.be>

```shell
kubectl apply -f kube/demo-backend.yaml
kubectl -n demo rollout status deployment/demo-backend
```

* look at the update history

```shell
kubectl rollout history -n demo deployment.v1.apps/demo-backend
```

* rollback to previous can be done with `undo`

```shell
kubectl rollout undo -n demo deployment.v1.apps/demo-backend
```

* or to a specific revision

```shell
kubectl rollout undo -n demo deployment.v1.apps/demo-backend --to-revision=2
```
