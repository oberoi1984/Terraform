provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "terraform-s3-bucket2024"

  tags = {
    Name        = "My Bucket"
    Environment = "Test"
  }
}

# Ownership controls for the S3 bucket
resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership" {
  bucket = aws_s3_bucket.test_bucket.id

  rule {
    object_ownership = "ObjectWriter"  # Use "ObjectWriter" if you need to use ACLs
  }
}

# Apply an ACL to the S3 bucket
resource "aws_s3_bucket_acl" "terraform_acl" {
  bucket = aws_s3_bucket.test_bucket.id
  acl    = "private"  # Change this to your desired ACL (e.g., "public-read", "private", etc.)

  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_ownership]
}

# Versioning configuration for the S3 bucket
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.test_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
