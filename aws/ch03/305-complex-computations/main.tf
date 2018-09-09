resource "local_file" "foo" {
  filename = "${path.module}/foo-${count.index}.txt"
  content = "foo-${count.index}"
  count = "${var.count}"
}

data "template_file" "do_hash" {
  template = "${sha1(element(local_file.foo.*.filename, count.index))}"
  count = "${var.count}"
}

resource "local_file" "foo_hash" {
  filename = "${path.module}/foo-hash.txt"
  content = "${join(",", data.template_file.do_hash.*.rendered)}"
}
