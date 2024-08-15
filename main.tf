# Configure the Kubernetes provider with the path to your kubeconfig file
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Define a Kubernetes deployment resource
resource "kubernetes_deployment" "passapp" {
  metadata {
    name = "passapp"                   # The name of the deployment
    labels = {
      app = "passapp"                  # Labels for the deployment
    }
  }
  spec {
    replicas = 2                       # Number of replicas (Pods) to create
    selector {
      match_labels = {
        app = "passapp"                # Match the labels to identify Pods managed by this deployment
      }
    }
    template {
      metadata {
        labels = {
          app = "passapp"              # Labels for the Pod template
        }
      }
      spec {
        container {
          image = "nissim2305/pass_app:latest"  # Docker image for the container
          name  = "passapp"            # Name of the container
          port {
            container_port = 5000      # Container port to expose
          }
        }
      }
    }
  }
}

# Define a Kubernetes service resource
resource "kubernetes_service" "passapp" {
  metadata {
    name = "passapp-service"           # The name of the service
  }
  spec {
    selector = {
      app = "passapp"                  # Selects Pods with the label 'app=passapp'
    }
    port {
      port        = 80                 # The port that the service will expose
      target_port = 5001               # The target port on the Pods
    }
    type = "NodePort"                  # Type of service (NodePort)
  }
}

