variable "zone_id" {
  description = "ZoneID for specific Domain"
  type        = string
}

variable "do_ipaddr" {
  description = "Public IP of DO Droplet"
  type        = string
}

variable "aws_ipaddr" {
  description = "Public IP of AWS IGW"
  type        = string
}

variable "demo_dns_name" {
  description = "The root resource name to be created under Cloudflare domain.  IE; 'demo' will be come 'demo.{domain from cf_zone}'"
  type        = string
  default     = "demo"
}

variable "is_premium_subscription" {
  description = "Is the account being used a premium 'paid' subcription?  Impacts select actions like tags"
  type        = bool
  default     = false
}

variable "tags_local" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default = {
    terraform = "true"
    module    = "cloudflare"
  }
}

variable "tags" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default     = {}
}