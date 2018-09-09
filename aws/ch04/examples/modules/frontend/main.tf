# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = "${var.aws_region}"
  version = "1.35"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
  required_version = ">= 0.11.8"
}

provider "template" {
  version = "1.0.0"
}
