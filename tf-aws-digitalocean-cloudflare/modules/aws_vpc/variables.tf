variable "environment" {
  description = "Envirionment Name"
  type		  = string
}

variable "vpc_master_cidr" {
  description = "Master VPC CIDR Range"
  type        = string
}

variable "vpc_subnets_cidr" {
  description = "List of Subnets to assign to AZ's"
  type        = list(string)
}

variable "az_list" {
  description = "List of Availability Zones to use"
  type		  = list(string)
}

variable "home_ipaddr" {
  description = "IP Address of Home Network"
  type        = string
}