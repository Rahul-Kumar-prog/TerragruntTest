variable "region" {}
variable "account_id" {}

output "network_info" {
  value = "Region=${var.region}, Account=${var.account_id}"
}