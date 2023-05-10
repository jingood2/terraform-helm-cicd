terraform {
  required_version = ">= 1.0.1"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.8.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14"
    }

  }

  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  #host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, list("")), 0)
  #cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, list("")), 0))
  #token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, list("")), 0)
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_id]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_id]
      command     = "aws"
    }
  }
}

provider "kubectl" {
  apply_retry_count      = 10
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_id]
    command     = "aws"
  }
}




#backend "remote" {
#  hostname = "app.terraform.io"
#  organization = "jingood2"

#  workspaces {
#    prefix = "helloworld-"
#  }
#}
