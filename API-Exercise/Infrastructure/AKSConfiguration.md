# Requirements
1. Have access to a machine/image with `az` cli
2. Have credentials to connect to azure portal with sufficient rights to interact with  `Azure AKS` and its parent `Resource Group`

# Basics

1. Login to Azure
    >`az login`
2. Recover your user informations and subscriptions informations
    >`az account list`
    

# Create a new container registry including a windows node
> `TODO`

# Authentication

To authenticate with AKS
> `az aks get-credentials -n <KubernetesInstanceName> -g <ParentResourceGroup>`

Alternatively, if you have multiple subscriptions for that user, you need to specify the CLIENT_ID of this subscription
> `az aks get-credentials -n <KubernetesInstanceName> -g <ParentResourceGroup> --subscription <CLIENT_ID>`

After getting the authentication token, if you don't have kubectl available in your path, you will have a hint stating that you can add the azure provided `kubectl` downloaded at `~\.azure`. This gives you the liberty not to install kubectl locally + let az cli handle the right version of kubectl for you.

# Enable AKS to pull images from a custom repository such as ACR
> `kubectl create secret docker-registry opcontainerregistry.azurecr.io --namespace <TargetNamespace> --docker-server=<RepositoryFullURI> --docker-username=<Username> "--docker-password=<Password>" "--docker-email=<NotificationEmail>"`