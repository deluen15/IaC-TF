provider "kubernetes" {
  host                   = var.host
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}
resource "kubernetes_deployment" "MyExampleApp" {
  metadata {
    name   = "terraform-aks"
    labels = {
      test = "MyExampleApp"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        test = "MyExampleApp"
      }
    }
    template {
      metadata {
        labels = {
          test = "MyExampleApp"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "aks-deployment"

          resources {
            limits   = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/nginx_status"
              port = "80"
              http_header {
                name  = "Header"
                value = "Awesome"
              }
            }
            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "aks-service" {
  metadata {
    name = "aks-service-example"
  }
  spec {
    selector = {
      test = "aks-service"
    }
    port {
      port        = 80
      target_port = 80
    }
    type     = "NodePort"
  }
}
resource "kubernetes_ingress" "aks-ingress" {
  metadata {
    name        = "aks-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service_name = kubernetes_service.aks-service.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}
