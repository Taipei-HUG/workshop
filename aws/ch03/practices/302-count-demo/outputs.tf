output "values" {
  value = "${data.template_file.foo.*.rendered}"
}
