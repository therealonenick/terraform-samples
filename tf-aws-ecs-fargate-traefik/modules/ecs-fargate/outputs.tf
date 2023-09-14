output "ecs" {
  value = {
    aws_ecs_cluster = aws_ecs_cluster.traefik_demo.id
  }
}

output "loadbalancer" {
  value = {
    fqdn = aws_lb.this.dns_name
  }
}

output "access_urls" {
  value = {
    whoami            = "http://${local.access_fqdn}"
    traefik_dashboard = "http://${local.access_fqdn}:8080/dashboard/"
  }
}