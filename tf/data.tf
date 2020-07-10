data "aws_ssm_parameter" "orgs_map" {
  name = "/${var.github_repository}/OrgsMap"
}
