data "template_file" "cloud-init-yaml" {
  template = file(var.cloud_init_file)
}

data "aws_ami" "al2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "demo" {
  depends_on                  = [var.vpc_sg]
  ami                         = data.aws_ami.al2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [var.vpc_sg]
  subnet_id                   = var.vpc_subnets[0]
  key_name                    = var.ec2_keypair
  user_data                   = data.template_file.cloud-init-yaml.rendered
  tags                        = local.tags

}