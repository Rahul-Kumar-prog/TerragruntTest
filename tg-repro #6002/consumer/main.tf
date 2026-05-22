terraform {
  required_version = ">= 1.6"
}

variable "x" {}

output "received" {
  value = var.x
}