

# Procedure
[Example hyperlink](https://istio.io/docs/tasks/security/https-overlay/)
1. ```bash
    kubectl create namespace demo-https &&\
    kubectl label namespace demo-https istio-injection=enable
2. ```bash
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt -subj "CN=my-nginx/O=my-nginx" &&\
    kubectl create secret tls nginxsecret --key nginx.key --cert nginx.crt -n demo-https &&\
    kubectl create configmap nginxconfigmap --from-file=samples/https/default.conf -n demo-https
3. ```bash
    kubectl apply -f samples/https/nginx-app.yaml -n demo-https &&\
    kubectl get pod -n demo-https
4. ```bash
    bin/istioctl kube-inject -f samples/https/nginx-app.yaml | kubectl apply -n demo-https -f - &&\
    bin/istioctl kube-inject -f samples/sleep/sleep.yaml | kubectl apply -n demo-https -f -
5. ```
    kubectl exec $(kubectl get pod -n demo-https -l app=sleep -o jsonpath={.items..metadata.name}) -c sleep -n demo-https -- curl https://my-nginx -k