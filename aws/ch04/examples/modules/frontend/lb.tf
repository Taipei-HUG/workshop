# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE LB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb" "frontend" {
  name = "${local.phase}-frontend"

  load_balancer_type = "application"
  internal           = false
  subnets            = [
    "${data.aws_subnet_ids.default.ids}"
  ]

  security_groups = [
    "${aws_security_group.frontend_lb.id}",
  ]

  tags = "${merge(map(
      "Name", "${local.phase}-frontend"
    ), var.extra_tags)}"
}

resource "aws_lb_target_group" "frontend" {

  name = "${local.phase}-frontend"

  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${aws_default_vpc.default.id}"


  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    path = "/"
    port = "80"
    protocol = "HTTP"
    interval = 30
    matcher = 200
  }

  tags = "${merge(map(
      "Name", "${local.phase}-frontend"
    ), var.extra_tags)}"
}

resource "aws_lb_listener" "frontend_http" {

   load_balancer_arn = "${aws_lb.frontend.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
     target_group_arn = "${aws_lb_target_group.frontend.arn}"
     type = "forward"
   }
}

# ---------------------------------------------------------------------------------------------------------------------
# ATTACH THE ELB TO THE FRONTEND ASG
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_autoscaling_attachment" "frontend" {
  autoscaling_group_name = "${aws_autoscaling_group.frontend.name}"
  alb_target_group_arn   = "${aws_lb_target_group.frontend.arn}"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP THAT CONTROLS WHAT TRAFFIC CAN GO IN AND OUT OF THE LB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "frontend_lb" {
  vpc_id = "${aws_default_vpc.default.id}"
  name_prefix = "${local.phase}-frontend-"
  description = "open access for http protocol externally"

  tags = "${merge(map(
      "Name", "${local.phase}-frontend"
    ), var.extra_tags)}"
}

resource "aws_security_group_rule" "frontend_lb_egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.frontend_lb.id}"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "frontend_lb_ingress_http" {
  type              = "ingress"
  security_group_id = "${aws_security_group.frontend_lb.id}"

  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 80
  to_port     = 80
}
