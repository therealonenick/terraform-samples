data "template_file" "cloud-init-yaml" {
  template = file(var.cloud_init_file)
}


resource "digitalocean_droplet" "demo" {
  image     = "centos-7-x64"
  name      = "demo"
  region    = var.region
  size      = "s-1vcpu-2gb"
  vpc_uuid  = var.vpc_id
  ssh_keys  = [var.do_ssh_key]
  user_data = data.template_file.cloud-init-yaml.rendered
  tags      = local.tags_set
}

