output "public_ip" {
  value = "${join(",", aws_instance.example.*.public_ip)}"
}
