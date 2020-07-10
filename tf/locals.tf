locals {
  tags = {
    IaC        = "terraform"
    Repository = var.github_repository
  }

  orgs_map = jsondecode(data.aws_ssm_parameter.orgs_map.value)
}
