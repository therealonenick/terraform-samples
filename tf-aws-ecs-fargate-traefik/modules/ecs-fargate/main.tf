data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_lb" "this" {
  name               = replace("${var.name_prefix}-crtl-alb", "_", "-")
  internal           = var.alb_type_internal
  load_balancer_type = "application"
  security_groups    = var.alb_create_security_group ? [aws_security_group.alb_security_group[0].id] : var.alb_security_group_ids
  subnets            = var.alb_subnet_ids

  dynamic "access_logs" {
    for_each = var.alb_enable_access_logs ? [true] : []
    content {
      bucket  = var.alb_access_logs_bucket_name
      prefix  = var.alb_access_logs_s3_prefix
      enabled = true
    }
  }

  tags = var.tags
}

resource "aws_lb_target_group" "this" {
  name = join("-", [
    replace("${var.name_prefix}-crtl", "_", "-"),
    split("-", uuidv5(tostring(local.custom_uuid), tostring(var.whoami_port)))[4]
  ])
  port        = var.whoami_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled = true
    path    = "/health"
  }

  tags       = var.tags
  depends_on = [aws_lb.this]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "this_dashboard" {
  name = join("-", [
    replace("${var.name_prefix}-crtl", "_", "-"),
    split("-", uuidv5(tostring(local.custom_uuid), tostring(var.traefik_dashboard_port)))[4]
  ])
  port        = var.traefik_dashboard_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled = true
    path    = "/dashboard/"
  }

  tags       = var.tags
  depends_on = [aws_lb.this]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.whoami_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

}

resource "aws_lb_listener" "http_dashboard" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.traefik_dashboard_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this_dashboard.arn
  }
}


resource "aws_route53_record" "this" {
  count = var.route53_create_alias ? 1 : 0

  zone_id = var.route53_zone_id
  name    = var.route53_alias_name
  type    = "A"
  #ttl     = 60

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}
