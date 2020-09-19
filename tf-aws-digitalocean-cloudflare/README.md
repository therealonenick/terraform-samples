# tf-aws-digitalocean-cloudflare
### This example integrates three providers:

1. AWS
2. DigitalOcean
3. CloudFlare

### In this example, Terraform will:
1. AWS
* Create VPC, SecurityGroup, and IGW with rules to only allow SSH from a specific IP and HTTP from anywhere
* Create an EC2 Instance that will be setup with a cloud-init file that will run a docker demo of nginxdemos/hello

2. DigitalOcean
* Create VPC and Firewall with the same rules (SSH from an IP and HTTP from anywhere
* Create a Droplet that will be setup with a cloud-init file that will run a docker demo of nginxdemos/hello

3. CloudFlare
* Setup DNS Records that point to the dynamically created instances from AWS and DigitalOcean

## Variables
.deploy/dev.tfvars

**do_token** Digital Ocean Access Token
**cf_key** CloudFlar Access Key
**cf_zone** CloudFlare Zone ID
**cf_email** CloudFlare Account Email

## Run
Some of this can be automated with a Pipeline
1. Setup all your variables
2. copy `.deploy/dev.tfvars` to `./terraform.tfvars`
3. Run `terraform init`
4. Run `terraform plan --input=false --out=output.tfplan`
5. Run `terraform apply output.tfplan`

## Delete
Assuming this is run local and your terraform state file is already present, Pick one:
1. Validate Delete: Run `terraform destroy`
2. Autoconfirm Delete: Run `terraform destroy --auto-approve`
