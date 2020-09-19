variable "environment" {
  description = "Envirionment Name"
  type		  = string
}

variable "vpc_master_cidr" {
  description = "Master VPC CIDR Range"
  type        = string
}

variable "object_lock" {
  description = "Object lock for S3 (In Years)"
  type        = string
}

variable "vpc_subnets_cidr" {
  description = "List of Subnets to assign to AZ's"
  type        = list(string)
}

variable "home_ipaddr" {
  description = "IP Address of Home Network"
  type        = string
}

variable "do_token" {
  description = "Digital Ocean Token"
  type        = string
}

variable "cf_key" {
  description = "CloudFlare Access Key"
  type        = string
}

variable "cf_zone" {
  description = "ZoneID for specific Domain"
  type        = string
}

variable "cf_email" {
  description = "Email of account"
  type        = string
}

variable "cloud_init_file" {
  description = "Cloud-init yaml file"
  type        = string
}

variable "ec2_keypair" {
  description = "EC2 Keypair Name for Instance"
  type        = string
}

variable "do_ssh_key" {
  description = "DO SSH KeyID to use with Droplet"
  type        = string
}