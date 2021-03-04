terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.4"
    }
  }
}
