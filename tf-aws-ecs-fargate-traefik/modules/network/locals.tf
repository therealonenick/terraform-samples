locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  az_list = flatten([
    for k, v in data.aws_availability_zones.available.names : v if k <= (var.az_count - 1)
  ])

  tags = merge(var.tags_local, var.tags)
}