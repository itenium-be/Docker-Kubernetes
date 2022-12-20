# Istio dark release

- create file `demo-istio/demo-backend-v1-2.yaml` with version 1.2 of the backend:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: istio-demo
  name: demo-backend-v1-2
  labels:
    app: demo-backend
    version: v1.2
spec:
  replicas: 2
  selector:
    matchLabels:
      app: demo-backend
      version: v1.2
  template:
    metadata:
      namespace: istio-demo
      labels:
        app: demo-backend
        version: v1.2
    spec:
      containers:
        - name: demo-backend
          image: jeankedotcom/demo-backend:v1.2
          resources:
            limits:
              cpu: 1500m
              memory: 1024Mi
            requests:
              cpu: 50m
              memory: 50Mi
```

- deploy version 1.2 of the backend

```shell
kubectl apply -f demo-istio/demo-backend-v1-2.yaml
```

- check the frontend <http://app.istio.itenium-training.be/> the service is going all over the place...

- create destionation rule file `demo-istio/demo-destinationrule.yaml`

```yaml
kind: DestinationRule
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: demo-backend
  namespace: istio-demo
spec:
  host: demo-backend
  subsets:
    - labels: # SELECTOR.
        version: v1.1
      name: v1-1
    - labels: # SELECTOR.
        version: v1.2
      name: v1-2
```

- deploy the destination rule

```shell
kubectl apply -f demo-istio/demo-destinationrule.yaml
```

- modify `demo-istio/demo-gateway.yaml`

```yaml
  # replace the http portion of the demo-backend virtual service with this one
  http:
    - match:
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

- check the frontend <http://app.istio.itenium-training.be/> (all should go to v1.1 now)

- install the `Redirect URL, Modify Headers & Mock APIs` plugin in chrome https://chrome.google.com/webstore/detail/redirect-url-modify-heade/mdnleldcmiljblolnjhpnblkcekpdkpa/related

- add an http rule
  - for urls containing `api.istio.itenium-training.be`
  - add request header
  - with name `tenant`
  - and value `Zellik`

- check if the rule is functioning in the chrome devtools

- by toggling the rule you should be able to switch backend versions
