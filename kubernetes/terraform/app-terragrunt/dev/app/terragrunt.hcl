locals {
  terraform_config     = read_terragrunt_config(find_in_parent_folder("terragrunt-config.hcl"))
  tag                  = local.terraform_config.locals.tag
  environment_specific = read_terragrunt_config(find_in_parent_folder("environment_specific.hcl"))
  env                  = local.environment_specific.environment
}
include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "../terraform/modules/cluster"
}
inputs = {

}
