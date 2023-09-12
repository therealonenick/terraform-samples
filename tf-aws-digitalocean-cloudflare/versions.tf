terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.16.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.4"
    }
  }
}
