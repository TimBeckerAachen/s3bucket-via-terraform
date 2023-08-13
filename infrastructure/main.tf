# Make sure to create state bucket beforehand
terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket  = "terraform-states-cloud"
    key     = "state"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
  profile = "aws-test"
}

data "aws_caller_identity" "current_identity" {}

locals {
  account_id = data.aws_caller_identity.current_identity.account_id
  common_tags = {
    project = var.project_id
    owner = var.owner
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}-${var.project_id}"
  force_destroy = true
}

output "bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}
