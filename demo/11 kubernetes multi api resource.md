# 11 Kubernetes multi api resource

* resources in YAML files can be separated by a line with 3 dashes

```yaml
---
```

## Exercise

* create one yaml file that will deploy a `your-app` application
  * for container image `devgem/my-app:3.0`
  * the app should be hosted on `yourapp.itenium-training.be`
  * the message should be "Hello from yourapp on Kubernetes"
  * all kubernetes resources should be called `your-app` instead of `my-app`
  