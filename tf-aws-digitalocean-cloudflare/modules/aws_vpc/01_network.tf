resource "aws_vpc" "main" {
  cidr_block = var.vpc_master_cidr
  tags = merge(local.tags, {
    Name = var.vpc_name
  })
}


resource "aws_subnet" "primary" {
  count = length(var.vpc_subnets_cidr)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.vpc_subnets_cidr, count.index)
  availability_zone       = element(var.az_list, count.index)
  map_public_ip_on_launch = false
  tags                    = local.tags
}

