data "template_file" "dev" {
  template = "dev"
  count = "${var.env == "production" ? 0 : 1}"
}

data "template_file" "prod" {
  template = "prod"
  count = "${var.env == "production" ? 1 : 0}"
}
