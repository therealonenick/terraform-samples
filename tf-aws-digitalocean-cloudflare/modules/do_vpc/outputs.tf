output "main" {
  value = {
    vpc_id			        = digitalocean_vpc.main.id
    vpc_urn             = digitalocean_vpc.main.urn
    vpc_default         = digitalocean_vpc.main.default
  }
}

