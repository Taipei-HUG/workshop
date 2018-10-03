
provider "github" {
  token        = "${var.github_token}"
}

resource "github_repository" "new_repo" {
  name        = "${var.github_repo_name}"
  description = "Test for Terraform github provider"

  private = false
}

/*
# Use ONLY for organization repo
resource "github_repository_deploy_key" "repository_deploy_a_key" {
    title = "Deployment key from terraform"
    repository = "${var.github_repo_name}"
    key = "${file("key.pub")}"
    read_only = "true"
}
*/
