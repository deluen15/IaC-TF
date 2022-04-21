terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.2.0"
    }
  }
  #  backend "azurerm" {
  #    resource_group_name  = "tf_rg_blobstore"
  #    storage_account_name = "tfstorageIaC"
  #    container_name       = "tfstate"
  #    key                  = "terraform.tfstate"
  #  }
}
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.serviceprinciple_id
  client_secret   = var.serviceprinciple_key
  tenant_id       = var.tenant_id
  features {}
}

module "cluster" {
  source               = "./modules/cluster/"
  serviceprinciple_id  = var.serviceprinciple_id
  serviceprinciple_key = var.serviceprinciple_key
  ssh_key              = var.ssh_key
  location             = var.location
  kubernetes_version   = var.kubernetes_version
}
module "k8s" {
  source                 = "./modules/k8s/"
  client_certificate     = base64decode(module.cluster.client_certificate)
  client_key             = base64decode(module.cluster.client_key)
  cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
  host                   = module.cluster.host
  dockerimage            = var.imagebuild
}

module "docker" {
  source     = "./modules/docker/"
  imagebuild = var.imagebuild
}
