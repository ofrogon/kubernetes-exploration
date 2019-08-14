# ---------------------------
# Create Azure Kubernetes
# ---------------------------

output "kubernetes_cluster_name" {
  value = "${azurerm_kubernetes_cluster.demo.name}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.demo.kube_config.0.client_certificate}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.demo.kube_config_raw}"
}

# ---------------------------
# Create Azure Storage Container
# ---------------------------

output "storage_account_name" {
  value = "${azurerm_resource_group.demo.name}"
}

output "storage_container_name" {
  value = "${azurerm_storage_container.demo.name}"
}
