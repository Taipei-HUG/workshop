# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN AUTO SCALING GROUP (ASG) TO RUN FRONTEND
# ---------------------------------------------------------------------------------------------------------------------

locals {
  extra_tags_keys   = "${keys(var.extra_tags)}"
  extra_tags_values = "${values(var.extra_tags)}"
}

data "null_data_source" "tags" {
  count = "${length(keys(var.extra_tags))}"

  inputs = {
    key                 = "${local.extra_tags_keys[count.index]}"
    value               = "${local.extra_tags_values[count.index]}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "frontend" {
  name_prefix = "${local.phase}-frontend-"

  vpc_zone_identifier = [
    "${data.aws_subnet_ids.default.ids}"
  ]

  launch_configuration = "${aws_launch_configuration.frontend.name}"

  min_size         = "${var.asg_config["instance_count"]}"
  max_size         = "${var.asg_config["instance_count"] * 3}"
  desired_capacity = "${var.asg_config["instance_count"]}"

  health_check_type         = "EC2"
  health_check_grace_period = 300
  wait_for_capacity_timeout = "10m"

  tags = [
    {
      key                 = "Name"
      value               = "${local.phase}-frontend"
      propagate_at_launch = true
    },
  ]

  tags = ["${data.null_data_source.tags.*.outputs}"]
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE LAUNCH CONFIGURATION TO DEFINE WHAT RUNS ON EACH INSTANCE IN THE ASG
# ---------------------------------------------------------------------------------------------------------------------

data "template_file" "frontend_user_data" {
  template = "${file("${path.module}/provision/user_data")}"
}

resource "aws_launch_configuration" "frontend" {
  name_prefix   = "${local.phase}-frontend-"
  image_id      = "${data.aws_ami.ubuntu_ami.image_id}"
  instance_type = "${var.asg_config["instance_type"]}"
  user_data     = "${data.template_file.frontend_user_data.rendered}"
  key_name      = "${var.ssh_key}"

  security_groups = [
    "${aws_security_group.frontend.id}"
  ]

  root_block_device {
    volume_type = "${var.asg_config["root_volume_type"]}"
    volume_size = "${var.asg_config["root_volume_size"]}"
  }

  # Important note: whenever using a launch configuration with an auto scaling group, you must set
  # create_before_destroy = true. However, as soon as you set create_before_destroy = true in one resource, you must
  # also set it in every resource that it depends on, or you'll get an error about cyclic dependencies (especially when
  # removing resources). For more info, see:
  #
  # https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
  # https://terraform.io/docs/configuration/resources.html
  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP TO CONTROL WHAT REQUESTS CAN GO IN AND OUT OF EACH EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "frontend" {
  name_prefix = "${local.phase}-frontend-"
  description = "Security group for the ${local.phase} frontend launch configuration"
  vpc_id      = "${aws_default_vpc.default.id}"


  # aws_launch_configuration.launch_configuration in this module sets create_before_destroy to true, which means
  # everything it depends on, including this resource, must set it as well, or you'll get cyclic dependency errors
  # when you try to do a terraform destroy.
  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(map(
      "Name", "${local.phase}-frontend"
    ), var.extra_tags)}"
}

resource "aws_security_group_rule" "frontend_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.frontend.id}"
}

resource "aws_security_group_rule" "frontend_ingress_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.frontend.id}"
}

resource "aws_security_group_rule" "frontend_ingress_elb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.frontend_lb.id}"

  security_group_id = "${aws_security_group.frontend.id}"
}
