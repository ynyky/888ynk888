provider "aws" {
  region = "eu-west-1"  # Change to your preferred region
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"  # Replace with a unique bucket name
  acl    = "private"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}

# DynamoDB Table
resource "aws_dynamodb_table" "my_table" {
  name           = "my-dynamodb-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }

  tags = {
    Name        = "MyDynamoDBTable"
    Environment = "Production"
  }
}

# ECR Repository
resource "aws_ecr_repository" "my_repository" {
  name = "my-ecr-repo"  # Replace with your desired repository name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "MyECRRepository"
    Environment = "Production"
  }
}