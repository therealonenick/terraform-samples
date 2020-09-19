variable "environment" {
  description = "Envirionment Name"
  type		  = string
}

variable "vpc_master_cidr" {
  description = "Master VPC CIDR Range"
  type        = string
}

variable "region" {
  description = "DO Region"
  type        = string
}

variable "home_ipaddr" {
  description = "IP Address of Home Network"
  type        = string
}