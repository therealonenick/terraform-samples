locals {
  tags = merge(var.tags_local, var.tags)
  tags_set = flatten([
    for k, v in local.tags : "${k}_${v}"
  ])
}