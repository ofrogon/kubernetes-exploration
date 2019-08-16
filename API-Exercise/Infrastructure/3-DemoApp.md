# Requirements
You must have completed [Istio initialisation](./2-Istio.md) and its requirements

# Note
> You must run all of the following commands in bash

# Initialisation
1. ([See documentation for the long version](https://istio.io/docs/examples/bookinfo/))
2. Open a bash cmdline inside ar the root folder of your istio release folder downloaded from the [istio procedure](./2-Istio.md)
3. Lets create a namespace named `demo-bookstore` with istio sidecar injection enabled:
    ```bash
    kubectl create namespace demo-bookstore &&\
    kubectl label namespace demo-bookstore istio-injection=enabled
    ```
4. Initialize the bookstore inside that namespace:
    ```bash
    kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml -n demo-bookstore
    ```
5. Check the state of your deployments:
    ```bash
    kubectl get services -n demo-bookstore &&\
    kubectl get pods -n demo-bookstore
    ```
6. Confirm that the application works:
    ```bash
    kubectl exec -n demo-bookstore -it $(kubectl get pod -n demo-bookstore -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
    ```
# Expose your app to the internet
1. Expose it to the internet:
    ```bash
    kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml -n demo-bookstore
    ```
2. Make sure it's properly deployed:
    ```bash
    kubectl get gateway -n demo-bookstore
    ```
3. Follow [these instructions](https://istio.io/docs/tasks/traffic-management/ingress/ingress-control/#determining-the-ingress-ip-and-ports) or run the following script to gather the necessary informations:
    ```bash
    export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}') &&\
    export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}') &&\
    export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}') &&\
    export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
    ```
4. Confirm the app is accessible outside the cluster:
    ```bash
    curl -s http://${GATEWAY_URL}/productpage | grep -o "<title>.*</title>"
    ```

# Enable mTLS for all services inside namespace "demo-bookstore"
1. Run apply the following configuration to enfore mTLS in STRICT mode over the whole namespace "demo-bookstore":
    ```bash
    kubectl apply -f samples/bookinfo/networking/destination-rule-all-mtls.yaml -n demo-bookstore
    ```
2. Check TLS configuration:
    ```bash
    PRODUCTPAGE_POD=$(kubectl get pod -n demo-bookstore -l app=productpage -o jsonpath={.items..metadata.name}) &&\
    bin/istioctl authn tls-check -n demo-bookstore ${PRODUCTPAGE_POD} productpage.demo-bookstore.svc.cluster.local
    ```