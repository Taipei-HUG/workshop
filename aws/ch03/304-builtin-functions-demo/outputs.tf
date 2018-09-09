output "example_list1" {
  value = "${var.example_list1}"
}

output "example_list2" {
  value = "${var.example_list2}"
}

output "example_map" {
  value = "${var.example_map}"
}

output "concat(var.example_list1, var.example_list2)" {
  value = "${concat(var.example_list1, var.example_list2)}"
}

output "element(var.example_list1, 1)" {
  value = "${element(var.example_list1, 1)}"
}

output "join(\"-\", var.example_list1)" {
  value = "${join("-", var.example_list1)}"
}

output "file(\"example.txt\")" {
  value = "${file("${path.module}/example.txt")}"
}

output "length(var.example_list2)" {
  value = "${length(var.example_list2)}"
}

output "length(var.example_map)" {
  value = "${length(var.example_map)}"
}


output "length(\"Example String\")" {
  value = "${length("Example String")}"
}

output "lookup(var.example_map, \"key1\")" {
  value = "${lookup(var.example_map, "key1")}"
}
