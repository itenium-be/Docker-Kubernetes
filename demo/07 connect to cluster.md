# 07 Connect to cluster

# Digital Ocean

* Jan shows a target-cluster with its resources in Digital Ocean

## Lens

* install Lens: <https://k8slens.dev/>
* start Lens
* ctrl + Shift + A (or `Menu` > `File` > `Add Cluster...`)
* copy the contents of your kubeconfig file into the window and click `Add Cluster`
* explore your cluster

## kubectl

* download <https://dl.k8s.io/release/v1.25.0/bin/windows/amd64/kubectl.exe> and put it in your working folder
* copy your kubeconfig file in your working folder
* open a Windows Command Prompt and go to your working folder
* set an envirnment variable KUBECONFIG with your kubeconfig file name

```shell
set KUBECONFIG=k8s-jan-kubeconfig.yaml
```

* check if you can reach the node of your cloud cluster

```shell
kubectl get nodes
```

* when closing the prompt the environment variable will be gone and you revert to any previous configuration
* or you can just delete the environment variable

```shell
set KUBECONFIG=
```
