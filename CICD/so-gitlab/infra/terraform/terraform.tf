terraform {
  backend "s3" {
    bucket         = var.bucket_name
    key            = var.dynamodb_table_name
    region         = var.region
    encrypt        = true
    dynamodb_table = var.bucket_name
  }
}

