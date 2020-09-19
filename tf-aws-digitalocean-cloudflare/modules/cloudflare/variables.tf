variable "zone_id" {
  description = "ZoneID for specific Domain"
  type        = string
}

variable "do_ipaddr" {
  description = "Public IP of DO Droplet"
  type        = string
}

variable "aws_ipaddr" {
  description = "Public IP of AWS IGW"
  type        = string
}