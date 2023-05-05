# helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
# helm repo update
# helm install sealed-secrets -n kube-system --set-string fullnameOverride=sealed-secrets-controller sealed-secrets/sealed-secrets
resource "helm_release" "sealed-secrets" {
  count = var.enable_sealed_secrets ? 1 : 0

  name             = "sealed-secrets-controller"
  repository       = "https://bitnami-labs.github.io/sealed-secrets"
  chart            = "sealed-secrets"
  namespace        = "kube-system"
  version          = "2.8.2"
  values = [
    "${file("values/sealed-secrets.yaml")}"
  ]
}