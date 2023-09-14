resource "aws_ecs_cluster" "traefik_demo" {
  name = "${var.name_prefix}-main"

  tags = var.tags
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "traefik_demo" {
  cluster_name = aws_ecs_cluster.traefik_demo.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_kms_key" "cloudwatch" {
  description = "KMS for cloudwatch log group"
  policy      = data.aws_iam_policy_document.cloudwatch.json
}

resource "aws_cloudwatch_log_group" "traefik_demo_log_group" {
  name              = var.name_prefix
  retention_in_days = var.traefik_demo_task_log_retention_days
  kms_key_id        = aws_kms_key.cloudwatch.arn
  tags              = var.tags
}

resource "aws_ecs_task_definition" "traefik_demo" {
  family = var.name_prefix

  task_role_arn            = var.traefik_demo_task_role_arn != null ? var.traefik_demo_task_role_arn : aws_iam_role.traefik_demo_task_role.arn
  execution_role_arn       = var.ecs_execution_role_arn != null ? var.ecs_execution_role_arn : aws_iam_role.ecs_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.traefik_demo_cpu
  memory                   = var.traefik_demo_memory
  container_definitions    = local.reports_ecs_containers_def

  tags = var.tags
}

resource "aws_ecs_service" "traefik_demo" {
  name = "${var.name_prefix}-traefik"

  task_definition  = aws_ecs_task_definition.traefik_demo.arn
  cluster          = aws_ecs_cluster.traefik_demo.id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  // Assuming we cannot have more than one instance at a time. Ever. 
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0


  service_registries {
    registry_arn = aws_service_discovery_service.traefik.arn
    port         = 8079
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = local.controller_name
    container_port   = var.whoami_port
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this_dashboard.arn
    container_name   = local.controller_name
    container_port   = var.traefik_dashboard_port
  }

  network_configuration {
    subnets          = var.proxy_access_subnet_ids
    security_groups  = [aws_security_group.traefik_demo_security_group.id]
    assign_public_ip = false
  }

  depends_on = [aws_lb_listener.http]
}

resource "aws_service_discovery_private_dns_namespace" "traefik" {
  name        = var.name_prefix
  vpc         = var.vpc_id
  description = "Serverless Reports discovery managed zone."
}

resource "aws_service_discovery_service" "traefik" {
  name = "traefik"
  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.traefik.id
    routing_policy = "MULTIVALUE"
    dns_records {
      ttl  = 10
      type = "A"
    }

    dns_records {
      ttl  = 10
      type = "SRV"
    }
  }
  health_check_custom_config {
    failure_threshold = 5
  }
}
