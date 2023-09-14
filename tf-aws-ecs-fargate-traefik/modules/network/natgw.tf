resource "aws_eip" "natgw" {
  count = var.nat_gateway_count
}

resource "aws_nat_gateway" "natgw" {
  count = var.nat_gateway_count

  allocation_id = aws_eip.natgw[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags          = local.tags
}

resource "aws_route_table" "private_rt" {
  count = length(local.az_list)

  vpc_id = aws_vpc.main.id
  tags = merge(local.tags, {
    Name = "${var.vpc_name}-private-rt-${count.index}"
  })
}

resource "aws_route" "natgw" {
  count = length(local.az_list)

  route_table_id         = aws_route_table.private_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_count > count.index ? aws_nat_gateway.natgw[count.index].id : aws_nat_gateway.natgw[0].id
}


resource "aws_route_table_association" "private" {
  count = length(local.az_list)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}
