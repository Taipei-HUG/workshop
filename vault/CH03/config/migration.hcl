storage_source "file" {
  path = "/vault/file"
}

storage_destination "dynamodb" {
ha_enabled = "true"
  region     = "us-west-2"
  table      = "vault-workshop"
}
