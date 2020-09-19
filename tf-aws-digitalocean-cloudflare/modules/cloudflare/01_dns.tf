resource "cloudflare_record" "aws" {
  zone_id = var.zone_id
  name    = "aws"
  value   = var.aws_ipaddr
  type    = "A"
  ttl     = 300
}

resource "cloudflare_record" "do" {
  zone_id = var.zone_id
  name    = "do"
  value   = var.do_ipaddr
  type    = "A"
  ttl     = 300
}

resource "cloudflare_record" "rounddobin_a_aws" {
  zone_id = var.zone_id
  name    = "test"
  value   = var.aws_ipaddr
  type    = "A"
  ttl     = 120
}

resource "cloudflare_record" "rounddobin_a_do" {
  zone_id = var.zone_id
  name    = "test"
  value   = var.do_ipaddr
  type    = "A"
  ttl     = 120
}