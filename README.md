
#

## dashboard

The dashboard is available at [http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/#!/overview](http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/#!/overview)

## access from host

```
export KUBECONFIG=${PWD}/config
```

```
KUBECONFIG=config kubectl get nodes
```
