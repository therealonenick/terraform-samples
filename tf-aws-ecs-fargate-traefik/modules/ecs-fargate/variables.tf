variable "name_prefix" {
  type        = string
  description = "name to use with resource prefixes"
  default     = "traefik-fargate"
}

variable "vpc_id" {
  type        = string
  description = "The VPC-ID to use for attaching resources"
}

variable "alb_type_internal" {
  type    = bool
  default = false
}

variable "alb_enable_access_logs" {
  type    = bool
  default = false
}

variable "alb_access_logs_bucket_name" {
  type    = string
  default = null
}

variable "alb_access_logs_s3_prefix" {
  type    = bool
  default = null
}

variable "alb_create_security_group" {
  type        = bool
  description = <<EOF
Should a security group allowing all traffic on ports 80 * 443 be created for the alb.
If false, a valid list of security groups must be passed with 'alb_security_group_ids'
EOF
  default     = true
}

variable "alb_security_group_ids" {
  type        = list(string)
  description = "A list of security group ids to attach to the Application Load Balancer"
  default     = null
}

variable "alb_ingress_allow_cidrs" {
  type        = list(string)
  description = "A list of cidrs to allow inbound into Reports."
  default     = null
}

variable "alb_subnet_ids" {
  type        = list(string)
  description = "A list of subnets for the Application Load Balancer"
  default     = null
}

variable "whoami_port" {
  type    = number
  default = 80
}

variable "traefik_dashboard_port" {
  type    = number
  default = 8080
}

variable "traefik_demo_cpu" {
  type    = number
  default = 2048
}

variable "traefik_demo_memory" {
  type    = number
  default = 4096
}

variable "traefik_demo_task_log_retention_days" {
  type    = number
  default = 30
}

variable "proxy_access_subnet_ids" {
  type        = list(string)
  description = "A list of subnets for the base ui access fargate service (required)"
  default     = null
}

variable "traefik_demo_task_role_arn" {
  type        = string
  description = "An custom task role to use for the reports controller (optional)"
  default     = null
}

variable "ecs_execution_role_arn" {
  type        = string
  description = "An custom execution role to use as the ecs exection role (optional)"
  default     = null
}

variable "route53_create_alias" {
  type    = bool
  default = false
}

variable "route53_zone_id" {
  type    = string
  default = null
}

variable "route53_alias_name" {
  type    = string
  default = "traefik-demo"
}

variable "tags_local" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default = {
    terraform = "true"
    module    = "ecs-fargate"
  }
}

variable "tags" {
  description = "Object of tags to add to resources"
  type        = map(string)
  default     = {}
}
