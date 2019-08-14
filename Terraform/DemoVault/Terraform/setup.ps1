# Warning:
# This script considers that you have only one subscription and / or that the good subscription is currently used

# Get Subscription and tenant ID
$accountDetails = az account show --query "{subscriptionId:id, tenantId:tenantId}" | ConvertFrom-Json

# Create a ServicePrincipal for Terraform and will need appId and password
$terraformUser = az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$($accountDetails.subscriptionId)" | ConvertFrom-Json

# Set the environment variables for Terraform
[Environment]::SetEnvironmentVariable("ARM_SUBSCRIPTION_ID", $accountDetails.subscriptionId, "User")
[Environment]::SetEnvironmentVariable("ARM_CLIENT_ID",       $terraformUser.appId,           "User")
[Environment]::SetEnvironmentVariable("ARM_CLIENT_SECRET",   $terraformUser.password,        "User")
[Environment]::SetEnvironmentVariable("ARM_TENANT_ID",       $accountDetails.tenantId,       "User")

# Activate the Azure API preview features (for Windows node creation)
# https://github.com/Azure/AKS/blob/master/previews.md
az extension add --name aks-preview
az feature register -n WindowsPreview --namespace Microsoft.ContainerService
az provider register -n Microsoft.ContainerService
