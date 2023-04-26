output "argocd_manifest" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = helm_release.arogcd.manifest
}