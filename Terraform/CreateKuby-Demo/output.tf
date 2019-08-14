# ---------------------------
# Create Azure Kubernetes
# ---------------------------

output "kubernetes_cluster_name" {
  value = "${azurerm_kubernetes_cluster.vault.name}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.vault.kube_config.0.client_certificate}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.vault.kube_config_raw}"
}

# ---------------------------
# Create Azure Storage Container
# ---------------------------

output "storage_account_name" {
  value = "${azurerm_resource_group.vault.name}"
}

output "storage_container_name" {
  value = "${azurerm_storage_container.vault.name}"
}
