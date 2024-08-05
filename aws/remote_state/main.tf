terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-south-1"  # Specify your AWS region
}

# Retrieve current AWS account details
data "aws_caller_identity" "current" {}

# Local variable for the account ID
locals {
  account_id = data.aws_caller_identity.current.account_id
}

# Create the S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${local.account_id}-terraform-states"
  
  # Enable versioning for the bucket
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Create DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode    = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

output "s3_bucket_region" {
  value = aws_s3_bucket.terraform_state.region
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_lock.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.terraform_lock.arn
}
