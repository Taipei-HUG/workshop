variable "example_string" {
  type    = "string"  // Optional, default to string
  default = "example" // Optional, default to ""
}

variable "example_list" {
  type    = "list"
  default = ["v1", "v2"] // Optional, default to []
}

variable "example_map" {
  type = "map"

  // Optional, default to {}
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}
