# Istio fault injection

- modify `demo-istio/demo-gateway.yaml`

```yaml
  # replace the http portion of the demo-backend virtual service with this one
  http:
    - fault:
        abort:
          httpStatus: 555
          percentage:
            value: 80
      match:
        - headers:
            tenant:
              exact: Zellik
      route:
        - destination:
            host: demo-backend
            subset: v1-2
    - route:
        - destination:
            host: demo-backend
            subset: v1-1
```

- redeploy `demo-istio/demo-gateway.yaml`

```shell
kubectl apply -f demo-istio/demo-gateway.yaml
```

- check the frontend <http://app.istio.itenium-training.be/> (calls should fail 80% off the time)
