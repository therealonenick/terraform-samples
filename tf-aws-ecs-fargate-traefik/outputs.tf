output "network" {
  value = var.deploy_network == true ? module.network[0].* : null
}

output "ecs" {
  value = module.ecs-fargate-traefik.ecs
}

output "alb" {
  value = module.ecs-fargate-traefik.loadbalancer
}

output "access_urls" {
  value = module.ecs-fargate-traefik.access_urls
}