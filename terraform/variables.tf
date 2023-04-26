# Input Variables
# AWS Region
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

