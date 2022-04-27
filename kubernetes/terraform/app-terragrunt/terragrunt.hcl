// locals {
//   environment_config = read_terragrunt_config(find_in_parent_folders("environment_specific.hcl"))
//   environment        = local.environment_config.locals.environment
// }

remote_state {
  backend  = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config   = {
    resource_group_name  = "tf_rg_blobstore"
    storage_account_name = "endristorageiac"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}
generate "terraform-config" {
  path      = "terraform-config.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        azurerm = {
          source = "hashicorp/azurerm"
          version = "3.2.0"
        }
         kubernetes = {
              source = "hashicorp/kubernetes"
            }
      }
    }
EOF
}
generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  provider "azurerm" {
    features {}
    subscription_id = "877bce2a-3a45-4d47-b0b9-430b3c3effae"
    client_id       = "b672f6f4-9f24-4ac0-9bae-cafcbfd49a08"
    client_secret   = "9Dw8Q~XEFHduBAv.iwbuYYgVNvOuubuRBVBaRbcn"
    tenant_id       = "c80e231a-f3b9-4aa1-bc83-0c3963feea70"
  }
  provider "kubernetes"{

  }
  EOF
}

