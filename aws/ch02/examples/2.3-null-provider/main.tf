provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "../credential.key"
}

data "aws_instances" "foo" {

  filter {
    name   = "tag:Name"
    values = ["DevOpsDays2018"]
  }

  instance_state_names = [ "running", "stopped" ]
}

resource "null_resource" "foo" {
  triggers = {
    cluster_instance_ids = "${join(",", data.aws_instances.foo.ids)}"
  }

  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    command = "echo ${join(" ", data.aws_instances.foo.ids)}"
  }
}

