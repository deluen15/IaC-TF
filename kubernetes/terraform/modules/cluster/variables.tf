#variable "serviceprinciple_id" {}
#variable "serviceprinciple_key" {}
variable "location" {
  default = "West Europe"
}
variable "kubernetes_version" {
  default = "1.23.3"
}
#variable "ssh_key" {}

variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}
