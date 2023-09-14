variable "deploy_network" {
  description = "Will deploy fresh VPC, Subnets, IGW, NATGW..etc.  If set to false, must supply all 'network_configs'"
  type        = bool
  default     = false
}

variable "network_configs" {
  description = "Configuration requirements if providing your own network"
  type = object({
    vpc_id             = string
    private_subnet_ids = list(string)
    public_subnet_ids  = list(string)
  })
  default = {
    vpc_id             = null
    private_subnet_ids = null
    public_subnet_ids  = null
  }
}

variable "route53_zone_id" {
  description = "Route53 Zone ID to use for DNS Alias creation"
  type        = string
  default     = null
}

variable "traefik_dns_alias" {
  type        = string
  description = <<EOF
The DNS alias to be associated with the deployed jenkins instance. Alias will
be created in the given route53 zone
EOF
  default     = "traefiktest"
}

variable "web_access_ips" {
  type        = list(string)
  description = "List of IP's in CIDR notiation to allow access to the services behind ALB"
  default     = []
}

variable "name_prefix" {
  type        = string
  description = "Default prefix for resource names"
  default     = "traefikFargate"
}