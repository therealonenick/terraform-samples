# tf-aws-ecs-fargate-traefik

### This example integrates:

1. AWS - ECS Fargate

### In this example, Terraform will:

1. Create an ECS Faragte Service and required security groups
2. Deploy:
* [traefik proxy](https://traefik.io/traefik/)
* [traefik whoami](https://github.com/traefik/whoami)

3. Expose the following:
* Port 80 - Passthrough from Traefik Proxy => Whoami instance
* Port 8080/dashboard/ - Expose the Traefik Dashboard

**NOTE:** These can be found in the terraform output under `access_urls`

**NOTE:** All connections with this demo un-secure.  Since this is simply a demo on getting the service running, we do not allocate or create any certificates for it.  This is also because when using the custom DNS alias, it would be up to the user to ensure ACM and certificate delegation is previously setup and is out of scope for a demo/example.

### Access
After deployment, services can be accessed here:
* `http://{load_balanced_fqdn}` - Whoami
* `http://{load_balanced_fqdn}:8080/dashboard/` - Traefik Dashboard

**NOTE:** If you provide a Route53 ZoneID, then you can access it at the Route53 alias you provided

## Variables

.deploy/dev.tfvars

* `deploy_network (bool)` (optional) - Whether or not to also deploy core network resrouces (vpc, subnets, NATGW, IGW).  Default: `false`

* `network_configs (object/map)` (optional) - Fill in the blank.  Required if `deploy_network` is `false`.

* `route53_zone_id (string)` (optional) - The Route53 zoneID if you have one and want to deploy an easy name.

* `traefik_dns_alias (string)` (optional) - The alias name to use if Route53 ZoneID is provided.

* `web_access_ips (list of strings)` - List of CIDR Block notation IP's to access the resources.  

* `name_prefix (string)` - A name prefix to use when creating resources

## Setup

There is no major setup for this template as it can just be run locally to showcase what is posisble.

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
