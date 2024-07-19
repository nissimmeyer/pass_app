provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "myapp-pass" {
  metadata {
    name = "myapp-pass"
    labels = {
      app = "myapp-pass"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "myapp-pass"
      }
    }
    template {
      metadata {
        labels = {
          app = "myapp-pass"
        }
      }
      spec {
        container {
          image = "nissim2305/myapp-pass"
          name  = "myapp-pass"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "myapp-pass" {
  metadata {
    name = "myapp-pass-service"
  }
  spec {
    selector = {
      app = "myapp-pass"
    }
    port {
      port        = 80
      target_port = 5000
    }
    type = "NodePort"
  }
}
