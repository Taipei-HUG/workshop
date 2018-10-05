# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt

terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"

    config {
      encrypt        = true
      bucket         = "taipei-hug-workshop"
      key            = "account_a/ap-northeast-1/dev/${path_relative_to_include()}/terraform.tfstate"
      region         = "us-west-2"
    }
  }

  # Configure root level variables that all resources can inherit
  terraform {
    extra_arguments "bucket" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      required_var_files = [
        "${get_parent_tfvars_dir()}/env.tfvars",
      ]
    }
  }
}
