variable "vpc_sg" {
  description = "VPC Security Group to Use"
  type        = string
}

variable "vpc_subnets" {
  description = "VPC Subnets"
  type        = list(string)
}

variable "cloud_init_file" {
  description = "Cloud-init yaml file"
  type        = string
}

variable "ec2_keypair" {
  description = "EC2 Keypair Name for Instance"
  type        = string
}

variable "tags_local" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default = {
    terraform = "true"
    module    = "aws_ec2"
  }
}

variable "tags" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default     = {}
}