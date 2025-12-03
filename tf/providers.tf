terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.24"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}
