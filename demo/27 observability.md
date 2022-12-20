# Istio observability

- install the observability stack

```shell
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.16/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.16/samples/addons/jaeger.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.16/samples/addons/grafana.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.16/samples/addons/kiali.yaml 
```

- check out the dashboards

```shell
# time-series database, used by istio for tracing and monitoring data
istioctl dashboard prometheus

# dashboard for prometheus
istioctl dashboard grafana

# end-to-end distributed tracing
istioctl dashboard jaeger

# aggregates data
istioctl dashboard kiali
# the graph view for the istio-demo namespace is very cool
```
