provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "../credential.key"
}


data "aws_instance" "foo" {

  filter {
    name   = "tag:Name"
    values = ["DevOpsDays2018"]
  }
}


data "template_file" "my_output" {
  template = "$${my_dump}"

  vars {
    my_dump = "${data.aws_instance.foo.public_ip}"
  }
}

