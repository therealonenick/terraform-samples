variable "environment" {
  description = "Envirionment Name"
  type        = string
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

variable "instance_id" {
  description = "Instance ID to apply FW too"
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
    module    = "do_vpc"
  }
}

variable "tags" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default     = {}
}