terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


resource "aws_s3_bucket" "terraform-ftstate-backend" {
  bucket = "terraform-ftstate-backend"

  tags = {
    Name        = "terraform-ftstate-backend"
    Environment = "production"
  }
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.terraform-ftstate-backend.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket-versioning" {
  bucket = aws_s3_bucket.terraform-ftstate-backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-stute-dynamodb-table" {
  name         = "tfstate-dynamodb-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }
}