include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "shared" {
  config_path = "../shared_dep"
}

inputs = {
  x = dependency.shared.outputs.x
}

terraform {
  source = "../consumer"
}