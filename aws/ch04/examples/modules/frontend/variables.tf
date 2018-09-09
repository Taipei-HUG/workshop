variable "aws_region" {
  type        = "string"
  description = "The AWS region"
}

variable "ssh_key" {
  type        = "string"
  description = "The key name that should be used for the instances."
}

variable "asg_config" {
  type        = "map"
  description = "Desired instance configuration."
}

variable "extra_tags" {
  type    = "map"
  default = {}
}

locals {
  phase = "${lookup(var.extra_tags, "Phase", "dev")}"
}
