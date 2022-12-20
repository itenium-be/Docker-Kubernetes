# Istio canary release

- modify `demo-istio/demo-gateway.yaml`

```yaml
  # replace the http portion of the demo-backend virtual service with this one
  http:
    - route:
        - destination:
            host: demo-backend
            subset: v1-1
          weight: 70
        - destination:
            host: demo-backend
            subset: v1-2
          weight: 30
```

- redeploy `demo-istio/demo-gateway.yaml`

```shell
kubectl apply -f demo-istio/demo-gateway.yaml
```

- check the frontend <http://app.istio.itenium-training.be/> (it should toggle between versions but tilt more toward v1.1)