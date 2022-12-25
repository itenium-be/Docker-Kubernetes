# 18a Kubernetes probe

## Solution

* adjust `kube/demo-frontend.yaml`

```yaml
          readinessProbe:
            httpGet:
              path: /favicon.ico
              port: 80
            initialDelaySeconds: 10
            timeoutSeconds: 3
          livenessProbe:
            httpGet:
              path: /favicon.ico
              port: 80
            initialDelaySeconds: 10
            timeoutSeconds: 3
            periodSeconds: 5
```

* redeploy the frontend

```shell
kubectl apply -f kube/demo-frontend.yaml
```
