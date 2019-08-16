# Requirements
You must have followed all previous steps to setup properly your application as in [3-DemoApp.md](./3-DemoApp.md)

# Kiali Dashboard
[See documentation](https://istio.io/docs/tasks/telemetry/kiali/) for more details
1. To expose the dashboard to your local network, tun the following command:
    ```bash
    kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=kiali -o jsonpath='{.items[0].metadata.name}') 20001:20001
    ```
2. Open your browser at the following url [http://localhost:20001/kiali](http://localhost:20001/kiali)
3. You will be asked for a username and password, it's `admin` and `admin` by default with istio demo setup
4. To generate traffic, run the following command:
    ```bash
    curl http://$GATEWAY_URL/productpage
    ```
    note that `GATEWAY_URL` variable can be retrieved running the following command:
    ```bash
    export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}') &&\
    export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}') &&\
    export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}') &&\
    export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
    ```

