# Helm

## Follow along

* download the latest version of Helm for your platform from <https://github.com/helm/helm/releases>

* unpack it (on Linux `tar -zxvf helm-v3.10.2-linux-amd64.tar.gz`)

* copy the binary to a global path folder or the same folder as your `kubectl` is in (on Linux `mv linux-amd64/helm /usr/local/bin/helm`)

* check if Helm is working `helm version`

* add bitnami to your helm repository

```shell
helm repo add bitnami https://charts.bitnami.com/bitnami
```

* make sure your Kubernetes config is ok

```shell
set KUBECONFIG=k8s-jan-kubeconfig.yaml
kubectl get nodes
```

* open Lens, connect to your cluster, check the `Storage/PersistentVolumeClaims`

* install MongoDB cluster

```shell
helm install demo-mongodb-at-itenium-release --set architecture=replicaset --set global.storageClass=do-block-storage --set auth.rootUser=root --set auth.rootPassword=Goga_1234! --set replicaCount=3 bitnami/mongodb
```

* check installation in Lens (`Workloads/Overview`, `Workloads/Pods`, `Storage/PersistentVolumeClaims` and `Storage/PersistentVolumeClaims`)

* list the releases in Helm

```shell
helm list
```

* delete the MongoDB cluster

```shell
helm delete demo-mongodb-at-itenium-release
```

* check installation in Lens (`Workloads/Overview`, `Workloads/Pods` and `Storage/PersistentVolumeClaims`)

* delete the `Storage/PersistentVolumeClaims` in Lens

* check the `Storage/PersistentVolumes` in Lens

* mind the Helm chart documentation <https://github.com/bitnami/charts/tree/main/bitnami/mongodb/>

* check out Kubeapps

```shell
# create namespace
kubectl create namespace kubeapps

# install Kubeapps in namespace
helm install kubeapps --namespace kubeapps bitnami/kubeapps --set useHelm3=true

# create admin account
kubectl create serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator

# get token on Linux
kubectl get secret $(kubectl get serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo

# get token on Windows
# create GetDashToken.cmd with the foloowing content
#------
@ECHO OFF
REM Get the Service Account
kubectl get serviceaccount kubeapps-operator -o jsonpath={.secrets[].name} > s.txt
SET /p ks=<s.txt
DEL s.txt

REM Get the Base64 encoded token
kubectl get secret %ks% -o jsonpath={.data.token} > b64.txt

REM Decode The Token
DEL token.txt
certutil -decode b64.txt token.txt
#------
# execute GetDashToken.cmd

# start proxy
kubectl port-forward -n kubeapps svc/kubeapps 8080:80

# check it out http://localhost:8080

# check the release
helm --namespace kubeapps list

#delete Kubeapps
helm --namespace kubeapps delete kubeapps
```