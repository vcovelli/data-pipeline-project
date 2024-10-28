# Provider configuration
provider "aws" {
  region = "us-east-1"
}

# S3 Bucket for raw data storage
resource "aws_s3_bucket" "raw_data_bucket" {
  bucket = "enterprise-raw-data-bucket"
}

# IAM Role for Lambda Function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_snowflake_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# Attach policies to Lambda IAM Role
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"  # Access to S3 bucket
}

# Lambda function to load data into Snowflake
resource "aws_lambda_function" "s3_to_snowflake" {
  function_name = "LoadS3ToSnowflake"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.handler"
  runtime       = "python3.8"
  source_code_hash = filebase64sha256("lambda/lambda_function.py")
  environment {
    variables = {
      SNOWFLAKE_USER     = "your_username"
      SNOWFLAKE_PASSWORD = "your_password"
      SNOWFLAKE_ACCOUNT  = "your_account"
      SNOWFLAKE_DATABASE = "your_database"
    }
  }
}

