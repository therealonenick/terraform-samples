resource "digitalocean_firewall" "TestFW" {
  name                    = "TestFW"

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