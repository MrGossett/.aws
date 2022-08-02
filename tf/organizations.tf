resource "aws_organizations_organization" "org" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "sso.amazonaws.com",
  ]
}
