terraform {
  backend "s3" {
    assume_role = {
      role_arn = "arn:aws:iam::123456789:role/role_name"
    }
    bucket                   = "some state bucket"
    dynamodb_table           = "some lock table"
    encrypt                  = true
    key                      = "someplace/terraform.tfstate"
    region                   = "us-east-1"
    shared_credentials_files = ["/tmp/state_credentials"]
  }
}