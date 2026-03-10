provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "hotstar-bucket-backend-1"

  tags = {
    Name        = "hotstar-bucket-backend-1"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "bucket1_versioning" {
  bucket = aws_s3_bucket.bucket1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "hotstar-bucket-backend-2"

  tags = {
    Name        = "hotstar-bucket-backend-2"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "bucket2_versioning" {
  bucket = aws_s3_bucket.bucket2.id
  versioning_configuration {
    status = "Enabled"
  }
}
