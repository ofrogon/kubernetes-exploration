# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  # https://github.com/terraform-providers/terraform-provider-azurerm/releases
  version = "=1.34.0"
}

# Create a resource group
resource "azurerm_resource_group" "demo" {
  name     = "${var.azure_group}-${var.azure_environment}"
  location = "${var.azure_location}"

  tags = {
      environment = "${var.azure_environment}"
  }
}

# Only to access the Azure data
data "azurerm_client_config" "current" {
}

# ---------------------------
# Create Azure Kubernetes
# ---------------------------

resource "azurerm_kubernetes_cluster" "demo" {
  name                = "${var.azure_group}-${var.azure_environment}-k8"
  location            = "${azurerm_resource_group.demo.location}"
  resource_group_name = "${azurerm_resource_group.demo.name}"

  dns_prefix          = "${var.azure_group}-${var.azure_environment}"
  kubernetes_version  = "${var.azure_kubernetes_version}"

  agent_pool_profile {
    name            = "linux"
    count           = 1
    vm_size         = "${var.azure_kubernetes_vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = "${var.azure_kubernetes_vm_disk_size}"
    type            = "VirtualMachineScaleSets"
    #node_taints     = ["Linux"]
  }

  # Windows support still in preview
  agent_pool_profile {
    name            = "win" # Max 6 characters!
    count           = 1
    vm_size         = "${var.azure_kubernetes_vm_size}"
    os_type         = "Windows"
    os_disk_size_gb = "${var.azure_kubernetes_vm_disk_size}"
    type            = "VirtualMachineScaleSets"
    #node_taints     = ["Windows"]
  }

  windows_profile {
    admin_username = "${var.azure_kubernetes_win_user}"
    admin_password = "${var.azure_kubernetes_win_pass}"
  }

  network_profile {
    network_plugin = "azure"
  }

  service_principal {
    client_id     = "${var.azure_connection_clientId}"
    client_secret = "${var.azure_connection_clientSecret}"
  }

  tags = {
    Environment = "${var.azure_environment}"
  }
}

# ---------------------------
# Create Azure Key Vault
# ---------------------------
resource "azurerm_key_vault" "demo" {
  name                        = "${var.azure_group}${var.azure_environment}KeyVault"
  location                    = "${azurerm_resource_group.demo.location}"
  resource_group_name         = "${azurerm_resource_group.demo.name}"

  enabled_for_deployment      = true
  enabled_for_disk_encryption = true
  tenant_id                   = "${var.azure_connection_tenantId}"

  sku_name = "standard"

  access_policy {
    tenant_id = "${var.azure_connection_tenantId}"
    object_id = "${data.azurerm_client_config.current.service_principal_object_id}"

    key_permissions = [
      "get",
      "list",
      "create",
      "delete",
      "update",
      "wrapKey",
      "unwrapKey",
    ]
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = {
    environment = "${var.azure_environment}"
  }
}

# ---------------------------
# Create Azure Storage Container
# ---------------------------
resource "azurerm_storage_account" "demo" {
  name                     = "${lower(var.azure_group)}${lower(var.azure_environment)}sa"
  location                 = "${azurerm_resource_group.demo.location}"
  resource_group_name      = "${azurerm_resource_group.demo.name}"

  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  tags = {
    environment = "${var.azure_environment}"
  }
}

resource "azurerm_storage_container" "demo" {
  name                  = "${lower(var.azure_group)}-${lower(var.azure_environment)}-storage"
  resource_group_name   = "${azurerm_resource_group.demo.name}"

  storage_account_name  = "${azurerm_storage_account.demo.name}"

  container_access_type = "private"
}

# ---------------------------
# Azure Container Registry
# ---------------------------

resource "azurerm_container_registry" "demo" {
  name                = "${lower(var.azure_group)}${lower(var.azure_environment)}cr"
  location            = "${azurerm_resource_group.demo.location}"
  resource_group_name = "${azurerm_resource_group.demo.name}"

  admin_enabled       = true
  sku = "${var.azure_container_registry_sku}"
}