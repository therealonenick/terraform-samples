resource "aws_security_group" "traefik_demo_security_group" {
  name                   = "${var.name_prefix}-traefik"
  description            = "${var.name_prefix} traefik security group"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  ingress {
    protocol        = "tcp"
    self            = true
    security_groups = var.alb_create_security_group ? [aws_security_group.alb_security_group[0].id] : var.alb_security_group_ids
    from_port       = var.traefik_dashboard_port
    to_port         = var.traefik_dashboard_port
    description     = "API Dashboard"
  }

  ingress {
    protocol        = "tcp"
    self            = true
    security_groups = var.alb_create_security_group ? [aws_security_group.alb_security_group[0].id] : var.alb_security_group_ids
    from_port       = var.whoami_port
    to_port         = var.whoami_port
    description     = "Web port"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

// ALB
resource "aws_security_group" "alb_security_group" {
  count = var.alb_create_security_group ? 1 : 0

  name                   = "${var.name_prefix}-alb"
  description            = "${var.name_prefix} alb security group"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = var.alb_ingress_allow_cidrs
    description = "HTTP Public access"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = var.alb_ingress_allow_cidrs
    description = "Dashboard Access Public access"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = var.alb_ingress_allow_cidrs
    description = "HTTPS Public access"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}