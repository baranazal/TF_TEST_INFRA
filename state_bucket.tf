# S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project}-terraform-state-${var.environment}"
  force_destroy = false

  # Prevent accidental deletion of this bucket
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "${var.project}-terraform-state-${var.environment}"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}

# Enable versioning so we can see the full revision history of our state files
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table for locking the state file
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.project}-terraform-locks-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.project}-terraform-locks-${var.environment}"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
} 