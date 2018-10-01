output "example_string" {
    value = "${var.example_string}"
}

output "example_list" {
    value = "${var.example_list}"
}

output "example_list[0]" {
    value = "${var.example_list[0]}"
}

output "example_map" {
    value = "${var.example_map}"
}

output "example_map[\"key1\"]" {
    value = "${var.example_map["key1"]}"
}
