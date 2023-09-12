
resource "digitalocean_tag" "this" {
  for_each = toset(local.tags_set)
  name     = each.value
}

resource "digitalocean_firewall" "this" {
  name        = "${var.vpc_name}-fw"
  droplet_ids = [var.instance_id]
  tags = flatten([for k in local.tags_set : digitalocean_tag.this[k].id])

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [var.home_ipaddr]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = [var.home_ipaddr]
  }
}
