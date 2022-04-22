resource "azurerm_resource_group" "IaC-aks-test" {
  location = var.location
  name     = "IaC-aks-test"
}

resource "azurerm_kubernetes_cluster" "IaC-aks-cluster" {
  name                = "IaC-aks-cluster"
  location            = azurerm_resource_group.IaC-aks-test.location
  resource_group_name = azurerm_resource_group.IaC-aks-test.name
  dns_prefix          = "IaC-aks-cluster"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_d2as_v5"
    type       = "VirtualMachineScaleSets"
  }

  service_principal {
    client_id     = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }
  #  identity {
  #    type = "SystemAssigned"
  #  }
  network_profile {
    network_plugin = "kubenet"
  }
}


#resource "azurerm_kubernetes_cluster_node_pool" "monitoring" {
#  kubernetes_cluster_id = azurerm_kubernetes_cluster.IaC-aks-cluster.id
#  name                  = "Monitoring"
#  vm_size               = "Standard_DS2_v2"
#  node_count            = 1
#  os_disk_size_gb       = 250
#  os_type               = "Linux"
#}
