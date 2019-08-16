# Requirements
1. Have access to a machine/image with `az` cli
2. Have credentials to connect to azure portal with sufficient rights to interact with  `Azure AKS` and its parent `Resource Group`
3. Have authenticated with aks using `az aks get-credentials...` ([See AKSConfiguiration.md for more info](./AKSConfiguration.md) )

# Note
> Helm acts on your current kubectl configuration. If you can interact with your kubernetes instance in azure with kubectl, so does your local helm cli.

# Initialization
[Official Microsoft Documentation](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm)

 1. Create Tiller RBAC to enable Helm in your cluster
    > `kubectl apply -f helm-rbac.yaml`
 2. helm init on all of your nodes (here we select only linux nodes)
    > `helm init --service-account tiller --node-selectors "beta.kubernetes.io/os"="linux"`

# Usage
* Update repositories list: 
    > `helm repo update`
* Explore available charts: 
    > `helm search`
* Install a chart: 
    > `helm install [whatever] -set controller.nodeSelector."beta\.kubernetes\.io/os"=linux --namespace [whatever]`
* Find helm deployed apps: 
    > `helm list`
* Delete helm deployed app: 
    > `helm delete`

 
