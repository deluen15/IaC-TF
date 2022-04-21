variable "serviceprinciple_id" {
}

variable "serviceprinciple_key" {
}

variable "tenant_id" {
}

variable "subscription_id" {
}


variable "ssh_key" {
}

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
