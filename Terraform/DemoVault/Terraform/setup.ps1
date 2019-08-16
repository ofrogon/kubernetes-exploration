# Get Subscription and tenant ID
# id => subscriptionId
$accountDetails = az account list | ConvertFrom-Json
if($accountDetails.Count -and $accountDetails.Count -gt 1) {
  $accountDetails = $accountDetails | Out-GridView -OutputMode Single
}

# Create a ServicePrincipal for Terraform and will need appId and password
$terraformUser = az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$($accountDetails.id)" | ConvertFrom-Json

# Set the environment variables for Terraform
[Environment]::SetEnvironmentVariable("ARM_SUBSCRIPTION_ID", $accountDetails.id,       "User")
[Environment]::SetEnvironmentVariable("ARM_CLIENT_ID",       $terraformUser.appId,     "User")
[Environment]::SetEnvironmentVariable("ARM_CLIENT_SECRET",   $terraformUser.password,  "User")
[Environment]::SetEnvironmentVariable("ARM_TENANT_ID",       $accountDetails.tenantId, "User")

# Activate the Azure API preview features (for Windows node creation)
# https://github.com/Azure/AKS/blob/master/previews.md
az extension add --name aks-preview
az feature register -n WindowsPreview --namespace Microsoft.ContainerService
az provider register -n Microsoft.ContainerService
