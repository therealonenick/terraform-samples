variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "region" {
  description = "DO Region"
  type        = string
}

variable "cloud_init_file" {
  description = "Cloud-init YAML file"
  type        = string
}

variable "do_ssh_key" {
  description = "SSH KeyID to use with DO Instance"
  type        = string
}

variable "tags_local" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default = {
    terraform = "true"
    module    = "do_droplet"
  }
}

variable "tags" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default     = {}
}