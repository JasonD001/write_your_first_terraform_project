output "s3_bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.arn
}

output "s3_bucket_region" {
  description = "The region of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.region
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table for Terraform state locking"
  value       = aws_dynamodb_table.terraform_lock.name
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table for Terraform state locking"
  value       = aws_dynamodb_table.terraform_lock.arn
}
