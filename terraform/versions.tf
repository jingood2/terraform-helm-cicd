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



#backend "remote" {
#  hostname = "app.terraform.io"
#  organization = "jingood2"

#  workspaces {
#    prefix = "helloworld-"
#  }
#}
