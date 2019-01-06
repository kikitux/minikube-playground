provider "kubernetes" {}

resource "kubernetes_pod" "nginx" {
  metadata {
    name = "nginx-example"

    labels {
      App = "nginx"
    }
  }

  spec {
    container {
      image = "nginx:1.7.8"
      name  = "example"

      port {
        container_port = 80
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx-example"
  }

  spec {
    selector {
      App = "${kubernetes_pod.nginx.metadata.0.labels.App}"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}

output "nginx_url" {
  value = "http://127.0.0.1:8001/api/v1/namespaces/default/services/nginx-example/proxy/"
}
