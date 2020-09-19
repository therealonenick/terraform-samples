output "main" {
  value = {
    id			    = aws_vpc.main.id
    primary_sg	= aws_security_group.primary.id
    subnets     = aws_subnet.primary.*.id
  }
}

