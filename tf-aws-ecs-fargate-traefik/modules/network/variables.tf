variable "environment" {
  description = "Envirionment Name"
  type        = string
  default     = "demo"
}

variable "vpc_master_cidr" {
  description = "Primary VPC CIDR Range"
  type        = string
  default     = "172.20.0.0/21"
}

variable "vpc_public_subnets_cidr" {
  description = "List of Subnets to assign to AZ's"
  type        = list(string)
  default     = ["172.20.1.0/24", "172.20.2.0/24", "172.20.3.0/24"]
}

variable "vpc_private_subnets_cidr" {
  description = "List of Subnets to assign to AZ's defined in `az_count`"
  type        = list(string)
  default     = ["172.20.4.0/24", "172.20.5.0/24", "172.20.6.0/24"]
}

variable "az_count" {
  description = "Number of AZ's to use with Subnets.  Minimum of 2, max 3"
  type        = number
  default     = 2
  validation {
    condition = (
      var.az_count >= 2 &&
      var.az_count <= 3
    )
    error_message = "Value must be 2 or 3"
  }

}

variable "web_access_ips" {
  description = "List of CIDR block IP addresses for web access"
  type        = list(string)
}

variable "vpc_name" {
  description = "The name to assign to VPC via tag"
  type        = string
  default     = "DemoVPC"
}

variable "nat_gateway_count" {
  description = "Number of NATGW's to deploy.  Should be less-than or equal to number of AZ's used."
  type        = number
  default     = 1
}

variable "tags_local" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default = {
    terraform = "true"
    module    = "network"
  }
}

variable "tags" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default     = {}
}
