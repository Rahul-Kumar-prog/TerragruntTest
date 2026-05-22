include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  value = "hello"
}

inputs = {
  x = local.value
}

terraform {
  source = "../module"
}