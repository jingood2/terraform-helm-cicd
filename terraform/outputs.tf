output "kubeapps_manifest" {
  count = var.enable_argocd ? 1 : 0
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = helm_release.kubeapps.manifest
}

output "argocd_manifest" {
  count = var.enable_argocd ? 1 : 0
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = helm_release.arogcd.manifest
}

output "image_updater_manifest" {
  count = var.enable_argocd ? 1 : 0
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = helm_release.image-updater.manifest
}

output "chartmuseum_manifest" {
  count = var.enable_argocd ? 1 : 0
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = helm_release.chartmuseum.manifest
}

output "sealed_secrets_manifest" {
  count = var.enable_argocd ? 1 : 0
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = helm_release.sealed-secrets.manifest
}

output "traefik_manifest" {
  count = var.enable_argocd ? 1 : 0
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = helm_release.traefik.manifest
}