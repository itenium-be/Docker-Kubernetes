# 18 Kubernetes probe

## Follow along

* open <http://demo.itenium-training.be/>
* and Lens

* adjust `kube/demo-backend.yaml` to add a liveness and readiness probe in the containers item section

```yaml
          readinessProbe:
            httpGet:
              path: /api/health
              port: 80
            initialDelaySeconds: 10
            timeoutSeconds: 3
          livenessProbe:
            httpGet:
              path: /api/health
              port: 80
            initialDelaySeconds: 10
            timeoutSeconds: 3
            periodSeconds: 5
```

* redeploy the backend

```shell
kubectl apply -f kube/demo-backend.yaml
```

## Exercise

* define liveness and readiness probes for the frontend, you can use path `/favicon.ico`
