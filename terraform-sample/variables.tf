terraform {
  backend "local" {
  }
}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = "hoge"
  secret_key = "piyo"

  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3     = "http://localhost:4566"
    lambda = "http://localhost:4566" # EC2エンドポイントを追加
    iam    = "http://localhost:4566" # IAMエンドポイントを追加
  }
}

resource "aws_iam_role" "lambda_iam_role" {
  name = "terraform_lambda_ima_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# lambda用Policyの作成
resource "aws_iam_role_policy" "lambda_access_policy" {
  name   = "terraform_lambda_access_policy"
  role   = aws_iam_role.lambda_iam_role.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
POLICY
}