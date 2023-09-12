output "main" {
  value = {
    droplet_id  = digitalocean_droplet.demo.id
    droplet_urn = digitalocean_droplet.demo.urn
    droplet_ip  = digitalocean_droplet.demo.ipv4_address
  }
}
