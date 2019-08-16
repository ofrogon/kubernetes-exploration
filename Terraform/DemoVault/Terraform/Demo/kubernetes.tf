provider "helm" {
    kubernetes {
        config_path = "/path/to/kube_cluster.yaml"

        # TODO Add configue to connect to AKS here
    }
}

# ---------------------------
# Install Vault
# ---------------------------
data "helm_repository" "incubator" {
  name = "incubator"
  url  = "https://kubernetes-charts-incubator.storage.googleapis.com"
}

data "helm_release" "name" {
  name       = "${var.helm_release_name}"

  repository = "${data.helm_repository.incubator.metadata.0.name}"
  chart      = "vault"
  version    = "${var.helm_vault_version}"

  value = [
    "${file("../Vault/vault-value-terraform.yaml")}"
  ]

  # Set Azure Storage Connector
  set {
      name  = "vault.config.storage.azure.accountName"
      value = "${azurerm_storage_account.vault.name}"
  }

  set {
      name  = "vault.config.storage.azure.accountKey"
      # TODO find what set here
      value = ""
  }

  set {
      name  = "vault.config.storage.azure.container"
      value = "${azurerm_storage_container.vault.name}"
  }

  set {
      name  = "vault.config.storage.azure.environment"
      value = "${azurerm_resource_group.vault.name}"
  }

  # Set Azure Key Vault Connector
  set {
      name  = "vault.config.seal.azurekeyvault.tenant_id"
      value = "${azurerm_key_vault.vault.tenant_id}"
  }

  set {
      name  = "vault.config.seal.azurekeyvault.client_id"
      value = "${var.azure_connection_clientId}"
  }

  set {
      name  = "vault.config.seal.azurekeyvault.client_secret"
      value = "${var.azure_connection_clientSecret}"
  }

  set {
      name  = "vault.config.seal.azurekeyvault.vault_name"
      value = "${azurerm_key_vault.vault.name}"
  }

  set {
      name  = "vault.config.seal.azurekeyvault.key_name"
      value = "${azurerm_key_vault_key.generated.name}"
  }

  # Vault Options
  set {
      # Not sure of that link, may be to fix
      name  = "service.externalPort"
      value = 443
  }
}