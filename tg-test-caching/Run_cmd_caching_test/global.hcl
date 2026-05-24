locals {
  aws_regions = {
    dev = run_cmd(
      "--terragrunt-global-cache",
      "--terragrunt-quiet",
      "bash",
      "-lc",
      "var_name=\"$1\"; value=\"$${!var_name:-}\"; if [ -z \"$value\" ]; then echo \"Missing required environment variable: $var_name\" >&2; exit 1; fi; printf '%s' \"$value\"",
      "_",
      "AWS_REGION_DEV"
    )

    prod = run_cmd(
      "--terragrunt-global-cache",
      "--terragrunt-quiet",
      "bash",
      "-lc",
      "var_name=\"$1\"; value=\"$${!var_name:-}\"; if [ -z \"$value\" ]; then echo \"Missing required environment variable: $var_name\" >&2; exit 1; fi; printf '%s' \"$value\"",
      "_",
      "AWS_REGION_PROD"
    )
  }

  aws_account_ids = {
    dev = run_cmd(
      "--terragrunt-global-cache",
      "--terragrunt-quiet",
      "bash",
      "-lc",
      "var_name=\"$1\"; value=\"$${!var_name:-}\"; if [ -z \"$value\" ]; then echo \"Missing required environment variable: $var_name\" >&2; exit 1; fi; printf '%s' \"$value\"",
      "_",
      "AWS_ACCOUNT_ID_DEV"
    )

    prod = run_cmd(
      "--terragrunt-global-cache",
      "--terragrunt-quiet",
      "bash",
      "-lc",
      "var_name=\"$1\"; value=\"$${!var_name:-}\"; if [ -z \"$value\" ]; then echo \"Missing required environment variable: $var_name\" >&2; exit 1; fi; printf '%s' \"$value\"",
      "_",
      "AWS_ACCOUNT_ID_PROD"
    )
  }
}
