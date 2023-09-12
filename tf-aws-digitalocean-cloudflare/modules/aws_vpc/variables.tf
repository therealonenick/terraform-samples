variable "environment" {
  description = "Envirionment Name"
  type        = string
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
  type        = list(string)
}

variable "home_ipaddr" {
  description = "IP Address of Home Network"
  type        = string
}

variable "vpc_name" {
  description = "The name to assign to VPC via tag"
  type        = string
  default     = "DemoVPC"
}

variable "tags_local" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default = {
    terraform = "true"
    module    = "aws_vpc"
  }
}

variable "tags" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default     = {}
}