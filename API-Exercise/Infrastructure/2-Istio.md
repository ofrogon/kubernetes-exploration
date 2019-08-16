# Requirements
1. Helm configured and initialized ([See Helm.md for more info](./1-Helm.md))

# Notes
> All commands should be ran in bash

> [Istio ports and protocol name convention documentation](https://istio.io/docs/setup/kubernetes/additional-setup/requirements/)

# Initialization
1. Download an istio release locally ([See releases page](https://istio.io/docs/setup/kubernetes/#downloading-the-release))
and unzip it locally (you can change the version)
    ```bash
    curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.2.4 sh -
    ```
2. Install all template CRDs (Custom Resources Definitions) on your kubernetes cluster. Run the following command (bash) from the root of the unzipped istio release
    ```bash
    helm template install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -
    ```
3. Configure remaining CRDs
    ```bash
    for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done
    ```
4. Apply istio-demo.yaml to setup your cluster
    ```bash
    kubectl apply -f install/kubernetes/namespace.yaml &&\
    kubectl apply -f install/kubernetes/istio-demo-auth.yaml
    #kubectl apply -f install/kubernetes/istio-demo.yaml #In case you want to setup a cluster which can interact with non-istio services inside your kubernetes cluster
    ```
5. Follow the deploiyment process:
    ```
    kubectl get svc -n istio-system &&\
    kubectl get pods -n istio-system
    ```

# Sidecar Injection
The simplest way to work with istio is to use its automatic sidecar injection ([See documentation]())
Injection occurs at pod creation time.
To enable automatic sidecar injection, label your namespace with the proper tag:
```bash
kubectl label namespace [namespace-name] istio-injection=enabled
```

You can list all namespaces that have sidecar-injection enabled with the following command:
```bash
kubectl get namespace -L istio-injection
```