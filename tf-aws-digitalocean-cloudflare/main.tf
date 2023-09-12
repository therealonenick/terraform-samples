provider "aws" {
  region = "us-east-2"
}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  api_key = var.cf_key
  email   = var.cf_email
}

module "aws_vpc" {
  source           = "./modules/aws_vpc"
  vpc_master_cidr  = var.vpc_master_cidr
  vpc_subnets_cidr = var.vpc_subnets_cidr
  environment      = var.environment
  az_list          = local.aws_az_list
  home_ipaddr      = var.home_ipaddr
  tags             = var.tags
}

module "aws_ec2" {
  source          = "./modules/aws_ec2"
  vpc_sg          = module.aws_vpc.main.primary_sg
  vpc_subnets     = module.aws_vpc.main.subnets
  cloud_init_file = join("/", concat([abspath(path.cwd)], [var.cloud_init_file]))
  ec2_keypair     = var.ec2_keypair
  tags            = var.tags
}

module "do_vpc" {
  source          = "./modules/do_vpc"
  vpc_master_cidr = var.vpc_master_cidr
  environment     = var.environment
  region          = var.do_region
  home_ipaddr     = var.home_ipaddr
  instance_id     = module.do_droplet.main.droplet_id
  tags            = var.tags
}
module "do_droplet" {
  source          = "./modules/do_droplet"
  vpc_id          = module.do_vpc.main.vpc_id
  region          = local.do_region
  cloud_init_file = var.cloud_init_file
  do_ssh_key      = var.do_ssh_key
  tags            = var.tags
}

module "cloudflare" {
  source        = "./modules/cloudflare"
  zone_id       = var.cf_zone
  do_ipaddr     = module.do_droplet.main.droplet_ip
  aws_ipaddr    = module.aws_ec2.instance.public_ip
  demo_dns_name = var.demo_dns_name
  tags          = var.tags
}