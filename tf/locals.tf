locals {
  tags = {
    IaC  = "terraform"
    Repo = var.github_repository
  }

  orgs_map = jsondecode(data.aws_ssm_parameter.orgs_map.value)
}
