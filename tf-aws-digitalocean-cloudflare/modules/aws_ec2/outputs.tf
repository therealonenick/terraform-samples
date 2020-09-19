output "instance" {
  value = {
    id			    = aws_instance.demo.id
    public_ip       = aws_instance.demo.public_ip
    private_ip      = aws_instance.demo.private_ip
  }
}

