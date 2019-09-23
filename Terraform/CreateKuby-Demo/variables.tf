# ---------------------------
# Azure
# ---------------------------
variable "azure_group" {
  default = "Kubernetes"
}

variable "azure_location" {
  default = "East US"
}

variable "azure_environment" {
  default = "Demo"
}

# TODO check if useful
variable "azure_connection_subscriptionId" {
  # https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade
  # or
  # $ az account show --query "{subscriptionId:id}"
  description = "The Azure Subscription ID"
}

variable "azure_connection_tenantId" {
  # https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Properties
  # or
  # $ az account show --query "{tenantId:tenantId}"
  description = "The Azure Tanant ID"
}

variable "azure_connection_clientId" {
  # https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType//sourceType/ -> Application (client) ID
  description = "The same as the Application ID"
}

variable "azure_connection_clientSecret" {
  # https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType//sourceType/ -> Click on the user -> Certificates & secrets
  description = "The password/credential set on your application"
}

# ---------------------------
# Azure Kubernetes Cluster
# ---------------------------

variable "azure_kubernetes_version" {
  # Can determine available versions with : az aks get-versions --location eastus --output table
  default = "1.14.6"
}

variable "azure_kubernetes_vm_size" {
  default = "Standard_B2s"
}

variable "azure_kubernetes_vm_disk_size" {
  default = 30
}

variable "azure_kubernetes_win_user" {
  description = "The Windows Profile username"
  default = "demo"
}

variable "azure_kubernetes_win_pass" {
  description = "The Windows Profile username. Must be between 12 and 123 chars; have letter minuscules and majuscule; start with a letter; ..."
  default = "J4imeLesPatate3!!!"
}

# ---------------------------
# Azure Container Registry
# ---------------------------

variable "azure_container_registry_sku" {
  description = "The SKU, can be Classic, Standard or Premium"
  default = "Standard"
}
