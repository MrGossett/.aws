resource "aws_organizations_account" "indigo" {
  email = local.orgs_map["indigo"].email
  name  = local.orgs_map["indigo"].name
  tags  = local.tags
}

provider "aws" {
  region = var.aws_region
  alias  = "indigo"
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.indigo.id}:role/OrganizationAccountAccessRole"
  }
}

resource "aws_s3_bucket" "indigo_tfstate" {
  provider = aws.indigo
  bucket   = "terraform-state-${aws_organizations_account.indigo.id}"
  acl      = "private"
  tags     = local.tags
}

resource "aws_dynamodb_table" "indigo_tfstate" {
  provider     = aws.indigo
  name         = "TerraformStateLock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}

