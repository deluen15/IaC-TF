variable "serviceprinciple_id" {
  type        = string
  description = "Client ID with permissions to create resource in Azure, use evn Variable"
}

variable "serviceprinciple_key" {
  type        = string
  description = "Client secret with permissions to create resource in Azure, use evn Variable"
}

variable "tenant_id" {
  type        = string
  description = "Client tenant id, use env variables"
}

variable "subscription_id" {
  type        = string
  description = "Client id subscription, use env variables"
}
#variable "ssh_key" {
#}

variable "location" {
  default = "West Europe"
}

variable "kubernetes_version" {
  default = "1.23.3"
}
variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}

