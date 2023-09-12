variable "environment" {
  description = "Envirionment Name"
  type        = string
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

variable "aws_az_list" {
  description = "List of AZs for Subnet mappings (change provider regionif changing here)"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "do_region" {
  description = "which region in Digitial Ocean to place resources"
  type        = string
  default     = "nyc3"
}

variable "demo_dns_name" {
  description = "The root resource name to be created under Cloudflare domain.  IE; 'demo' will be come 'demo.{domain from cf_zone}'"
  type        = string
  default     = "demo"
}

variable "tags" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default = {
    terraform  = "true"
    deployment = "tf-aws-digitalocean-cloudflare-sample"
  }
}