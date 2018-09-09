output "ubuntu_ami_id" {
  value = "${data.aws_ami.ubuntu_ami.image_id}"
}

output "frontend_lb_dns_name" {
  value = "${aws_lb.frontend.dns_name}"
}
