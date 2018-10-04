resource "template_dir" "foo" {
  source_dir      = "${path.module}/example"
  destination_dir = "${path.module}/example"
}

data "template_file" "foo" {
  template = "Example template"
}

resource "local_file" "foo" {
  content  = "foo"

  // The file foo.txt will be located at module's path
  filename = "${path.module}/foo.txt"
}
