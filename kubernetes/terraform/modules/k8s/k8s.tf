terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
provider "kubernetes" {
  host                   = var.host
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}
resource "kubernetes_namespace" "aks-namespace" {
  metadata {
    name = "aks-deployment-and-service"
  }
}

resource "kubernetes_deployment" "aks-deployment" {
  metadata {
    namespace = kubernetes_namespace.aks-namespace.metadata.0.name
    name      = "terraform-aks"
    labels    = {
      app = "terraform-aks"
    }
  }
  spec {
    replicas = "3"
    selector {
      match_labels = {
        app = "terraform-aks"
      }
    }
    template {
      metadata {
        labels = {
          app = "terraform-aks"
        }
      }
      spec {
        container {
          #          image = "nginx:1.20.2-alpine"
          image = "endritzeqo/iac-tf:${var.dockerimage}"
          name  = "aks-deployment"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "aks-service" {
  metadata {
    namespace = kubernetes_namespace.aks-namespace.metadata.0.name
    name      = "aks-service-example"
  }
  spec {
    selector = {
      app = kubernetes_deployment.aks-deployment.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 8080
    }
    type     = "LoadBalancer"
  }
}

