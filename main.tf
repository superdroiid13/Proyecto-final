terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = var.aws_region
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  s3_use_path_style           = true   # NECESARIO para evitar error bucket.localhost

  endpoints {
    s3       = var.localstack_endpoint
    dynamodb = var.localstack_endpoint
    sqs      = var.localstack_endpoint
  }
}

# ------------------------------
# S3 BUCKET
# ------------------------------
resource "aws_s3_bucket" "main" {
  bucket        = "proyecto-final-21490077"
  force_destroy = true

  tags = {
    Name        = "proyecto-final-alumno-21490077"
    Environment = var.environment
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.main.id
  key    = "index.html"
  source = "index.html"
  etag   = filemd5("index.html")
}

# ------------------------------
# DYNAMODB TABLE
# ------------------------------
resource "aws_dynamodb_table" "usuarios" {
  name         = "Usuarios"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "UserID"

  attribute {
    name = "UserID"
    type = "S"
  }

  tags = {
    Name        = "Usuarios"
    Environment = var.environment
  }
}

# ------------------------------
# SQS QUEUE
# ------------------------------
resource "aws_sqs_queue" "web_queue" {
  name = "proyecto-final-21490077-queue"
}
