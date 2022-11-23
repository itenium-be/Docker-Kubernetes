# 13 Kubernetes TLS

## Follow along

* generate a self signed certificate for *.itenium-training.be (install openssl if needed: <https://www.sslcertificaten.nl/support/OpenSSL/OpenSSL_-_Installatie_onder_Windows>)

```shell
mkdir cert
openssl req -subj "/C=BE/ST=Brussel/L=Brussel/O=Itenium/OU=IT/CN=*.itenium-training.be" -newkey rsa:2048 -nodes -keyout cert/itenium-trainnig.be.key -x509 -days 365 -out cert/itenium-trainnig.be.crt
```

* create a secret in Kubernetes with the certificate as input

```shell
kubectl create secret tls tls-for-star.itenium.training.be --key cert/itenium-trainnig.be.key --cert cert/itenium-trainnig.be.crt
```

* you can also create a yaml file for the secret in e.g. `cert/tls.yaml` and apply it with kubectl but it is safer to not store the yaml in sourcecontrol and keep your .crt and .key files safe

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: tls-for-star.itenium.training.be
  namespace: default
type: kubernetes.io/tls
data:
  tls.crt: <FILL_IN_YOUR_CRT_BASE64_ENCODED>
  tls.key: <FILL_IN_YOUR_KEY_BASE64_ENCODED>
```

* add the `annotations` and `tls` sections to `kube/my-app-ingress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.org/ssl-services: "my-app-service"
spec:
  tls:
    - hosts:
        - myapp.itenium-training.be
      secretName: tls-for-star.itenium.training.be
  rules:
    - host: myapp.itenium-training.be
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: my-app-service
                port:
                  number: 80
  ingressClassName: nginx
```

* Redeploy the ingress

```shell
kubectl apply -f kube/my-app-ingress.yaml
```

* go to the http url and see it redirect from <http://myapp.itenium-training.be> to <https://myapp.itenium-training.be> (since it's a self generated certificate it's unsigned)