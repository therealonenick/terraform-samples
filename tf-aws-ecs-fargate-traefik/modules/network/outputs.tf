output "main" {
  value = {
    vpc_id              = aws_vpc.main.id
    primary_sg          = aws_security_group.primary.id
    public_subnet_ids   = aws_subnet.public.*.id
    private_subnet_ids  = aws_subnet.private.*.id
    nat_gateway_id      = aws_nat_gateway.natgw.*.id
    internet_gateway_id = aws_internet_gateway.igw.id
  }
}
