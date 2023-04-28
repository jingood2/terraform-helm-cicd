# helm repo add traefik https://helm.traefik.io/traefik
# helm repo update
# helm install traefik traefik/traefik --create-namespace traefik --version 23.0.1 -f terraform/values/traefik.yaml
resource "helm_release" "traefik" {
  count = var.enable_traefik? 1 : 0

  name        = "${local.prefix_name}-traefik"
  repository  = "https://helm.traefik.io/traefik"
  chart       = "traefik"
  namespace   = "traefik"
  create_namespace = true
  version     = "23.0.1"

  values = [
    "${file("values/traefik.yaml")}"
  ]
}