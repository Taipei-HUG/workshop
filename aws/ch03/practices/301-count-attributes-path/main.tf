resource "random_string" "password" {
  length = 16
}

data "template_file" "foo" {
  template = "foo"
}

data "template_file" "foo_with_count" {
  // interpolate the current index in a multi-count resource
  template = "foo-${count.index}"
  count    = 3
}
