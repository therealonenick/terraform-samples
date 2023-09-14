locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  ## Custom namespace UUID for generating uuidv5 values.
  custom_uuid   = "402b9362-f44e-4da2-9831-6512fa0720f4"
  tags          = merge(var.tags_local, var.tags)
  tmp_file_name = "traefik-test.tpl.json"
  reports_ecs_containers_def = templatefile("${path.module}/templates/${local.tmp_file_name}", {
    ACCESS_FQDN     = local.access_fqdn
    CLUSTER_NAME    = aws_ecs_cluster.traefik_demo.name
    CONTROLLER_NAME = local.controller_name
    LOGS_REGION     = local.region
  })

  access_fqdn     = var.route53_create_alias == true ? aws_route53_record.this[0].fqdn : aws_lb.this.dns_name
  controller_name = "${var.name_prefix}-traefik"

}
