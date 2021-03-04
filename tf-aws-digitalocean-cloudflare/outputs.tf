output "aws_vpc" {
  value = {
    main		= module.aws_vpc.main
  }
}

output "aws_ec2" {
  value = {
   instance_info  = module.aws_ec2.instance 
  }
}

output "do_vpc" {
  value = {
    main    = module.do_vpc.main
  }
}

output "do_droplet" {
  value = {
    main    = module.do_droplet.main
  }
}

output "cf_records" {
  value = {
    all     = module.cloudflare.records
  }
}