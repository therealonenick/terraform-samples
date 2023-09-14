data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_master_cidr
  tags = merge(local.tags, {
    Name = var.vpc_name
  })
}

resource "aws_subnet" "public" {
  count = length(var.vpc_public_subnets_cidr)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.vpc_public_subnets_cidr, count.index)
  availability_zone       = element(local.az_list, count.index)
  map_public_ip_on_launch = false
  tags                    = local.tags
}

resource "aws_subnet" "private" {
  count = length(var.vpc_private_subnets_cidr)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.vpc_private_subnets_cidr, count.index)
  availability_zone       = element(local.az_list, count.index)
  map_public_ip_on_launch = false
  tags                    = local.tags
}