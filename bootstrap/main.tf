resource "aws_s3_bucket" "backend_s3_bucket" {
  bucket = "project-2-tf"

  # Prevent accidental deletion of the bucket holding your Terraform state
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "project-2-tf-state"
    Environment = "shared"
    ManagedBy   = "Terraform"
  }
}

# Versioning lets you recover a previous state file if it gets corrupted
resource "aws_s3_bucket_versioning" "backend_s3_bucket" {
  bucket = aws_s3_bucket.backend_s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

