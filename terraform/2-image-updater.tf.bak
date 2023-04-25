# helm repo add argo https://argoproj.github.io/argo-helm
# helm repo update
# helm install updater -n argocd argo/argocd-image-updater --version 0.8.4 -f terraform/values/image-updater.yaml
resource "helm_release" "image-updater" {
  name       = "updater"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-image-updater"
  namespace   = "argocd"
  create_namespace = true
  version     = "0.9.0"
  values = [
    "${file("values/image-updater.yaml")}"
  ]
}