output "records" {
  value = {
    a_record_1 = cloudflare_record.rounddobin_a_aws
    a_record_2 = cloudflare_record.rounddobin_a_do
  }
}