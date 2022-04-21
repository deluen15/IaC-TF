resource "azurerm_resource_group" "docker_rg" {
  location = var.location
  name     = "docker_rg"
}

resource "azurerm_container_group" "docker_CI" {
  location            = azurerm_resource_group.docker_rg.location
  name                = "docker_CI"
  os_type             = "Linux"
  dns_name_label      = "iactest"
  resource_group_name = azurerm_resource_group.docker_rg.name
  container {
    cpu    = 1
    image  = "endritzeqo/iac-tf"
    memory = 1
    name   = "iac-tf"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}
