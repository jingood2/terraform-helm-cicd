aws_region  = "us-east-1"
environment = "dev"
project     = "jingood2"

cluster_id = "jingood2-dev-eks"

enable_kubeapps       = false
enable_argocd         = true
enable_image_updater  = false
enable_chartmuseum    = false
enable_sealed_secrets = true
enable_traefik        = true
enable_backstage      = true
enable_certmanager    = true