resource "helm_release" "cert-manager" {
  count = var.enable_certmanager ? 1 : 0

  name             = "cert-manager"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "cert-manager"
  namespace        = "kube-system"
  version          = "0.9.6"
  #values = [
  #  "${file("values/cert-manager.yaml")}"
  #]
}

resource "kubectl_manifest" "cloudflare-api-token-secret" {
  count = var.enable_certmanager? 1 : 0

  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-api-token-secret
type: Opaque
stringData:
  api-token: aVRaZnlYMUNZUHFyLXJNTDBzRWJkVWZkNkZ4TnZVbVRaMkt6NmY0Two=
YAML
}


resource "kubernetes_manifest" "letsencrypt_issuer_staging" {
  count = var.enable_certmanager? 1 : 0

  manifest = yamldecode(templatefile(
    "./manifests/cert-manager/cert-manager.tpl.yaml",
    {
      "k8s_cert_name"             = "example-com"
      "namespace"                 = "default"
      "acme_email"                = "jingood2+cloudflare@gmail.com"
      "cloudflare_email"          = "jingood2+cloudflare@gmail.com"
      "acme_server_url"           = "https://acme-staging-v02.api.letsencrypt.org/directory"
      "api_token_secret_name"     = "cloudflare-api-token-secret"
      "api_token_secret_data_key" = "api-token"
      "cloudflare_zone"           = "anyclouds.online"
    }
  ))

  depends_on = [helm_release.cert-manager, kubectl_manifest.cloudflare-api-token-secret ]
}








