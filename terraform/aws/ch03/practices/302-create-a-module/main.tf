module "child" {
  source = "./child"

  memory = "1G"
}

output "chile_memory" {
  value = "${module.child.received}"
}
