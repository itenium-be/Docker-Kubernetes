# Istio installation

* download latest version of Istio for your platform from <https://github.com/istio/istio/releases/>

* unpack it (on Linux `tar -zxvf istio-1.16.0-linux-amd64.tar.gz`)

* copy the binary to a global path folder or the same folder as your `kubectl` is in (on Linux `mv istio-1.16.0/bin/istioctl /usr/local/bin/istioctl`)

* make sure your Kubernetes config is ok

```shell
set KUBECONFIG=k8s-jan-kubeconfig.yaml
kubectl get nodes
```

* check if istioctl is working

```shell
istioctl version
```

* there are different pre-packaged installations for different Kubernetes setups (<https://istio.io/latest/docs/setup/platform-setup/>). We will use the "demo" setup which has a good set of generic default settings:

```shell
istioctl install --set profile=demo -y
```

* setting a label on a namespace will automatically inject the Envoy sidecar container an any applications deployed later:

```shell
kubectl create namespace istio-demo
kubectl label namespace istio-demo istio-injection=enabled
```

* adjust your `demo-staging.yaml` file
    * copy it to a folder names `demo-istio` and rename it to `demo-platform.yaml`
    * rename all `namespace: staging` to `namespace: istio-demo`
    * remove all ingress blocks
    * add a `version: v1.1` label to all labels on the demo-backend deployment
    * rename the `demo-backend` deployment to `demo-backend-v1-1`

* deploy the newly created yaml to your cluster

```shell
kubectl apply -f demo-istio/demo-platform.yaml
```

* check the `istio-demo` namespace in Lens
    * inspect a pod, see the sidecar container
    * inspect the `demo-backend` service and port-forward it to check the api in a browser
    * delete the port forward



