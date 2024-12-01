terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  region = "us-west-2"

  access_key = "hoge"
  secret_key = "piyo"

  s3_use_path_style = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://localhost:4566"
    lambda = "http://localhost:4566"
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    sqs = "http://localhost:4566"
    eventbridge = "http://localhost:4566"
  }
}

resource "aws_dynamodb_table" "users" {
  name           = "users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"
  attribute {
    name = "user_id"
    type = "S"
  }
  
}

resource "aws_sqs_queue" "queue" {
  name = "my-queue"
}

# EventBridgeルールの作成
resource "aws_cloudwatch_event_rule" "every_minute" {
  name = "every-minute"
  schedule_expression = "rate(1 minute)"
}

# EventBridgeルールに対するターゲットの作成
resource "aws_cloudwatch_event_target" "lambda_every_minute" {
  rule = aws_cloudwatch_event_rule.every_minute.name
  target_id = "runLambdaFunction"
  arn = aws_lambda_function.sqs_sender.arn 
}

variable "your_email" {
  type    = string
  default = "gottsutaku+sestest@email.com"
}