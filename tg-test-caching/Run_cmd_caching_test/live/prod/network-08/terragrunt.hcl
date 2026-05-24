locals {
  root_dir = abspath(dirname(find_in_parent_folders("global.hcl")))
  env      = basename(dirname(get_terragrunt_dir()))
  global   = read_terragrunt_config("${local.root_dir}/global.hcl")
}

terraform {
  source = "${local.root_dir}/modules/network"
}

inputs = {
  region     = local.global.locals.aws_regions[local.env]
  account_id = local.global.locals.aws_account_ids[local.env]
}
