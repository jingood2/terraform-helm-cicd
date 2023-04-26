# helm repo add bitnami https://charts.bitnami.com/bitnami
# helm repo update
# helm install argocd -n argocd --create-namespace argo/argo-cd --version 3.35.4 -f terraform/values/argocd.yaml
# kubectl get --namespace default secret kubeapps-operator-token -o go-template='{{.data.token | base64decode}}'
resource "helm_release" "kubeapps" {
  name        = "kubeapps"
  repository  = "https://charts.bitnami.com/bitnami"
  chart       = "kubeapps"
  namespace   = "kubeapps"
  create_namespace = true
  version     = "12.3.1"

  values = [
    "${file("values/kubeapps.yaml")}"
  ]
}

resource "kubectl_manifest" "serviceaccount" {
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kubeapps-operator 
  namespace: default
  resourceVersion: "340"
  uid: 63bd3d9e-6caa-463c-b23e-be99126b683f
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: kubeapps-operator
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: default:kubeapps-operator
  YAML
}

resource "kubectl_manifest" "kubeapps-operator-token" {
    yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: kubeapps-operator-token
  namespace: default
  annotations:
    kubernetes.io/service-account.name: kubeapps-operator
type: kubernetes.io/service-account-token
YAML
}