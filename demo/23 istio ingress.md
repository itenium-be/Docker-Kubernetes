# Istio ingress

* check the ip-address of tje `istio-ingressgateway` loadbalancer (206.189.241.44)

```shell
kubectl get services --namespace istio-system
```
* open `C:\Windows\System32\drivers\etc\hosts` in Notepad running as Administator
* add lines (replace the ip-adresses with the adresses of your `istio-ingressgateway` loadbalancer)

```shell
	206.189.241.44       api.istio.itenium-training.be
	206.189.241.44       app.istio.itenium-training.be
```

* create file `demo-istio/demo-gateway.yaml` with an istio gateway and 2 virtual services (1 for backend, 1 for frontend):

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  namespace: istio-demo
  name: demo-gateway
spec:
  selector:
    istio: ingressgateway # use istio default controller
  servers:
    - port:
        number: 80
        name: http
        protocol: HTTP
      hosts:
        - "*.istio.itenium-training.be"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  namespace: istio-demo
  name: demo-backend
spec:
  hosts:
    - "api.istio.itenium-training.be"
  gateways:
    - demo-gateway
  http:
    - route:
        - destination:
            host: demo-backend
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  namespace: istio-demo
  name: demo-frontend
spec:
  hosts:
    - "app.istio.itenium-training.be"
  gateways:
    - demo-gateway
  http:
    - route:
        - destination:
            host: demo-frontend
```

* deploy the gateway and virtual services

```shell
kubectl apply -f demo-istio/demo-gateway.yaml
```

* check out the backend <http://api.istio.itenium-training.be/>

* and the frontend <http://app.istio.itenium-training.be/>