resource "digitalocean_vpc" "main" {
  name                    = "TestVPC2"
  ip_range				  = var.vpc_master_cidr
  description             = "TestVPC"
  region                  = var.region
}