# Requirements
1. Have access to a machine/image with `az` and `docker` cli
2. Have credentials to connect to azure portal with sufficient rights to interact with  `Azure ACR` and its parent `Resource Group`

# Basics

1. Login to Azure
    >`az login`
2. Recover your user informations and subscriptions informations
    >`az account list`
    

# Create a new container registry
> `az acr create -n <RepositoryName> -g <ParentResourceGroup>`

# Authentication

To authenticate with ACR
>`az acr login -n <RepositoryName>`

Alternatively, if you have multiple subscriptions for that user, you need to specify the CLIENT_ID of this subscription
>`az acr login -n <RepositoryName> --subscription <CLIENT_ID>`

You will need a valid username and password to authenticate with ACR, you can add authentifiable users through your ACR In azure portal. [See Documentation for more informations.](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-roles) It is recommended to only give the required rights for headless users such as a CI/CD build user. In this case, you would need to only give Azure Push right.

Then, to enable docker to push images to the repository (helm is also supported on ACR)
>`docker login <RepositoryName>.azurecr.io -u <Username> -p <Password>`