locals {
    global = read_terragrunt_config(find_in_parent_folders("global.hcl")) 
}

terraform {
    source = "../../modules/app"
}

inputs = {
    region = local.global.locals.aws_region
    account_id = local.global.locals.aws_account_id
}