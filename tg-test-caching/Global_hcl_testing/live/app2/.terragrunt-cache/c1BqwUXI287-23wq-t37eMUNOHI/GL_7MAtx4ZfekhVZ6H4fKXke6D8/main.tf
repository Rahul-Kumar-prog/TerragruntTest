variable "region" {}
variable "account_id" {}

output "info" {
    value = "Region=${var.region}, Account=${var.account_id}"
}