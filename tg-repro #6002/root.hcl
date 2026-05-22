remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "test-bucket"
    key    = "${path_relative_to_include()}/tofu.tfstate"
    region = "us-east-1"
  }
}