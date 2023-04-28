output "kubeapps_manifest" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = var.enable_kubeapps ? helm_release.kubeapps.manifest : null
}

output "argocd_manifest" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = var.enable_arogcd ? helm_release.arogcd.manifest : null
}

output "image_updater_manifest" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = var.enable_image_updater ? helm_release.image_updater.manifest : null
}

output "chartmuseum_manifest" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = var.enable_chartmuseum ? helm_release.chartmuseum.manifest : null
}

output "sealed_secrets_manifest" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = var.enable_sealed_secrets ? helm_release.sealed_secrets.manifest : null
}

output "traefik_manifest" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = var.enable_traefik ? helm_release.traefik.manifest : null
}