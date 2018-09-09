resource "aws_default_vpc" "default" {
    tags {
        Name = "Default VPC"
    }
}

data "aws_subnet_ids" "default" {
  vpc_id = "${aws_default_vpc.default.id}"
}
