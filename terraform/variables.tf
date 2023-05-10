#####################################################################################
# Common Variables
#####################################################################################
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-1"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "dev"
}
# Project
variable "project" {
  description = "Project in the large organization this Infrastructure belongs"
  type        = string
  default     = "poc"
}

#####################################################################################
# Input Variables
#####################################################################################
variable "cluster_id" {
  description = "eks cluster id"
  type        = string
}

#####################################################################################
# Helm Chart Variables
#####################################################################################
variable "enable_kubeapps" {
  type        = bool
  description = "enable kubeapps helm create"
  default     = false
}
variable "enable_argocd" {
  type        = bool
  description = "enable argocd helm create"
  default     = false
}

variable "enable_image_updater" {
  type        = bool
  description = "enable argo image update helm create"
  default     = false
}

variable "enable_chartmuseum" {
  type        = bool
  description = "enable chartmuseum helm create"
  default     = false
}

variable "enable_sealed_secrets" {
  type        = bool
  description = "enable sealed secrets helm create"
  default     = false
}

variable "enable_traefik" {
  type        = bool
  description = "enable sealed secrets helm create"
  default     = false
}

variable "enable_backstage" {
  type        = bool
  description = "enable backstage"
  default     = false
}

variable "enable_certmanager" {
  type        = bool
  description = "enable cert-manager"
  default     = false
}
