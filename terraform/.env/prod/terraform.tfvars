aws_region  = "us-east-1"
environment = "prod"
project     = "jingood2"

cluster_id = "jingood2-prod-eks"

enable_kubeapps       = false
enable_argocd         = false
enable_image_updater  = false
enable_chartmuseum    = false
enable_sealed_secrets = false
enable_traefik        = false
enable_certmanager    = false
enable_aws_load_balancer_controller = true