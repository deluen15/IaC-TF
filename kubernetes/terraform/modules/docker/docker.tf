resource "azurerm_resource_group" "docker_rg" {
  location = var.location
  name     = "docker_rg"
}

resource "azurerm_container_group" "docker_CI" {
  location            = azurerm_resource_group.docker_rg.location
  name                = "docker_CI"
  os_type             = "ubuntu:latest"
  resource_group_name = azurerm_resource_group.docker_rg.name
  container {
    cpu    = 0
    image  = ""
    memory = 0
    name   = ""
  }
}
