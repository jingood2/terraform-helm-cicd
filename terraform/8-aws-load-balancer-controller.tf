# helm repo add aws https://aws.github.io/eks-charts
# helm repo update
# helm install my-aws-load-balancer-controller aws/aws-load-balancer-controller --version 1.5.2 -f terraform/aws-load-balancer-controller.yaml
resource "helm_release" "aws-load-balancer-controller" {
  count = var.enable_aws_load_balancer_controller? 1 : 0

  name       = "${local.prefix_name}-alb-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "default"
  #create_namespace = true
  version = "1.5.2"

  values = [
    "${file("values/alb-load-balancer-controller.yaml")}"
  ]

  set {
    name  = "clusterName"
    value = var.cluster_id
  }
}