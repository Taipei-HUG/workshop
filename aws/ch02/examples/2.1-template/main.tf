provider "aws" {
  region                  = "us-west-2"
}


data "aws_instance" "foo" {

  filter {
    name   = "tag:aws:cloudformation:logical-id"
    values = ["Instance"]
  }
}


data "template_file" "my_output" {
  template = "$${my_dump}"

  vars {
    my_dump = "${data.aws_instance.foo.public_ip}"
  }
}

