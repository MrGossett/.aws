resource "aws_organizations_account" "blue" {
  email = local.orgs_map["blue"].email
  name  = local.orgs_map["blue"].name
  tags  = local.tags
}

resource "aws_s3_bucket" "blue_tfstate" {
  bucket = "terraform-state-${aws_organizations_account.blue.id}"
  acl    = "private"
  tags   = local.tags
}

resource "aws_dynamodb_table" "blue_tfstate" {
  name         = "TerraformStateLock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

