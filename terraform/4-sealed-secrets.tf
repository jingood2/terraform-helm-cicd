# helm repo add argo https://chartmuseum.github.io/charts
# helm repo update
# helm install chartmuseum -n chartmuseum --create-namespace chartmuseum/chartmuseum --version 3.9.3 -f terraform/values/chartmuseum.yaml
resource "helm_release" "sealed-secrets" {
  count = var.enable_sealed_secrets? 1 : 0

  name             = "sealed-secrets"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "sealed-secrets"
  namespace        = "kube-system"
  create_namespace = true
  version          = "1.2.15"
  values = [
    "${file("values/sealed-secrets.yaml")}"
  ]
}