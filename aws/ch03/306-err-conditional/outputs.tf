output "success" {
  value = "${var.env == "dev" ? join("", data.template_file.dev.*.rendered) : join("", data.template_file.prod.*.rendered)}"
}

output "failure_cannot_be_used_with_list" {
  value = "${var.env == "dev" ? data.template_file.dev.*.rendered : data.template_file.prod.*.rendered}"
}

output "failure_cannot_be_resolved" {
  value = "${var.env == "dev" ? data.template_file.dev.rendered : data.template_file.prod.rendered}"
}
