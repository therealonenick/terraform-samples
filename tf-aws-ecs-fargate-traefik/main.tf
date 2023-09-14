provider "aws" {}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "network" {
  count          = var.deploy_network == true ? 1 : 0
  source         = "./modules/network"
  web_access_ips = var.web_access_ips
  tags           = local.tags
}

module "ecs-fargate-traefik" {
  source                  = "./modules/ecs-fargate"
  name_prefix             = var.name_prefix
  tags                    = local.tags
  vpc_id                  = var.deploy_network == true ? module.network[0].main.vpc_id : var.network_configs.vpc_id
  proxy_access_subnet_ids = var.deploy_network == true ? module.network[0].main.private_subnet_ids : var.network_configs.private_subnet_ids
  alb_subnet_ids          = var.deploy_network == true ? module.network[0].main.public_subnet_ids : var.network_configs.public_subnet_ids
  alb_ingress_allow_cidrs = var.web_access_ips
  route53_create_alias    = var.route53_zone_id == null ? false : true
  route53_alias_name      = var.route53_zone_id == null ? null : var.traefik_dns_alias
  route53_zone_id         = var.route53_zone_id == null ? null : var.route53_zone_id
}
