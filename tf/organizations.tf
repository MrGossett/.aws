resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

resource "aws_organizations_policy" "ai_opt_out" {
  name = "AIServicesOptOutAll"
  content = jsonencode({
    services = {
      "@@operators_allowed_for_child_policies" = ["@@none"],
      default = {
        "@@operators_allowed_for_child_policies" = ["@@none"],
        opt_out_policy = {
          "@@operators_allowed_for_child_policies" = ["@@none"],
          "@@assign"                               = "optOut"
        }
      }
    }
  })
}

resource "aws_organizations_policy_attachment" "ai_opt_out_root" {
  for_each  = toset(aws_organizations_organization.org.roots.*.id)
  policy_id = aws_organizations_policy.ai_opt_out.id
  target_id = each.value
}
