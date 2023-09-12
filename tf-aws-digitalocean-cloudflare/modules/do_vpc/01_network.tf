resource "digitalocean_vpc" "main" {
  name        = var.vpc_name
  ip_range    = var.vpc_master_cidr
  description = var.vpc_name
  region      = var.region
}
