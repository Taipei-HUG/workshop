variable "example_list1" {
  type = "list"
  default = ["v1", "v2"]
}

variable "example_list2" {
  type = "list"
  default = ["v3", "v4"]
}

variable "example_map" {
  type = "map"
  default = {
    key1 = "value1",
    key2 = "value2",
  }
}
