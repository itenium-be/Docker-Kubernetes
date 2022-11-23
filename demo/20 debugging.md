# Debugging

## Lens

* check events
* check pod logs
* check pod console

## kubectl

* check events

```shell
kubectl get event
```

* check pod logs

```shell
kubectl logs nginx-pod
```

* check pod console

```shell
kubectl exec --stdin --tty  nginx-pod -- /bin/bash
```