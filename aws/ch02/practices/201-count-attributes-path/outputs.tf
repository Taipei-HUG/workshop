output "random_string.password.result" {
  value = "${random_string.password.result}"
}

output "data.template_file.foo.template" {
  value = "${data.template_file.foo.template}"
}

output "data.template_file.foo_with_count" {
  value = "${data.template_file.foo_with_count.*.rendered}"
}

output "path.module" {
  value = "${path.module}"
}
