# helm repo add argo https://chartmuseum.github.io/charts
# helm repo update
# helm install chartmuseum -n chartmuseum --create-namespace chartmuseum/chartmuseum --version 3.9.3 -f terraform/values/chartmuseum.yaml
resource "helm_release" "chartmuseum" {
  count = var.enable_chartmuseum? 1 : 0

  name             = "chartmuseum"
  repository       = "https://chartmuseum.github.io/charts"
  chart            = "chartmuseum"
  namespace        = "chartmuseum"
  create_namespace = true
  version          = "3.9.3"
  values = [
    "${file("values/chartmuseum.yaml")}"
  ]
}