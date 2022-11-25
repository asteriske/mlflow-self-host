job "mlflow" {
  region = "global"

  datacenters = ["DC0",]
  
  type = "service"
  
  group "svc" {
    count = 1
  
    network {
      port "mlflow_http" { to = 5000}
    }

    volume "mlflow-backend-store" {
      type      = "host"
      source    = "mlflow-backend-store"
      read_only = false
    }
  
    volume "mlflow-artifacts" {
      type      = "host"
      source    = "mlflow-artifacts"
      read_only = false
    }
  
    restart {
      attempts = 5
      delay    = "30s"
    }
  
    task "mlflow_app" {
      driver = "docker"
    
      config {
        image = "registry.lan:5000/mlflow:latest"
    
        ports = [ "mlflow_http" ]
      }
    
      env = {
      }
    
      resources {
        cpu    = 200
        memory = 512 
      }
    
      service {
          name = "mlflow"
          port = "mlflow_http"

          tags = [
            "traefik.enable=true",
            "traefik.http.routers.mlflow.rule=Host(`mlflow.lan`)",
          ]
        }

      volume_mount {
        volume      = "mlflow-artifacts"
        destination = "/mnt/artifacts"
        read_only   = false
      }

      volume_mount {
        volume      = "mlflow-backend-store"
        destination = "/mnt/backend_store"
        read_only   = false
      }
    }

  }
}
