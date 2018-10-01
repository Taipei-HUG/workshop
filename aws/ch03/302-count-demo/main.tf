data "template_file" "foo" {
  // interpolate the current index in a multi-count
  // resource
  template = "foo-${count.index}"

  count = 3
}
