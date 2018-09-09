output "resource_attribute" {
  value = "${template_dir.foo.destination_dir}"
}

output "data_resource_attribute" {
  value = "${data.template_file.foo.template}"
}
