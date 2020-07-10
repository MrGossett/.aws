resource "aws_organizations_account" "grey" {
  email = local.orgs_map["grey"].email
  name  = local.orgs_map["grey"].name
  tags  = local.tags
}

provider "aws" {
  region = var.aws_region
  alias  = "grey"
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.grey.id}:role/OrganizationAccountAccessRole"
  }
}

resource "aws_s3_bucket" "grey_tfstate" {
  provider = aws.grey
  bucket   = "terraform-state-${aws_organizations_account.grey.id}"
  acl      = "private"
  tags     = local.tags
}

resource "aws_dynamodb_table" "grey_tfstate" {
  provider     = aws.grey
  name         = "TerraformStateLock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

