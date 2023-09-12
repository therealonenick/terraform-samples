#Environment
environment="dev"

# Shared Network Config
vpc_master_cidr = "172.20.0.0/22"
vpc_subnets_cidr = ["172.20.1.0/24", "172.20.2.0/24", "172.20.3.0/24"]
home_ipaddr         = ""

#AWS
ec2_keypair = ""

#Cloud-init file
cloud_init_file = "cloud-init/cloud-init.yml"

#AWS DyanmoDB Lock
object_lock = "1"

#Digital Ocean
do_token = ""
do_ssh_key = ""

#CloudFlare
cf_email = ""
cf_zone = ""
cf_key = ""
