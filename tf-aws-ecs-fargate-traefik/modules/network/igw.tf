resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "${var.vpc_name}-igw"
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "${var.vpc_name}-public-rt"
  })
}

resource "aws_route" "igw" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(local.az_list)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}