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
    client_id     = "b672f6f4-9f24-4ac0-9bae-cafcbfd49a08"
    client_secret = "9Dw8Q~XEFHduBAv.iwbuYYgVNvOuubuRBVBaRbcn"
  }
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
