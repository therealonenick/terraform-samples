#Environment
environment="dev"

# Shared Network Config
vpc_master_cidr = "10.64.56.0/22"
vpc_subnets_cidr = ["10.64.56.0/24", "10.64.57.0/24", "10.64.58.0/24"]
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
