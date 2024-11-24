resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-bucket"
}

data "archive_file" "test_terraform" {
  type        = "zip"
  source_dir  = "lambda/test/src"
  output_path = "lambda/test/src/test_terraform.zip"
}

resource "aws_lambda_function" "my-lambda" {
  function_name    = "test-function"
  filename         = data.archive_file.test_terraform.output_path
  source_code_hash = data.archive_file.test_terraform.output_base64sha256
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_iam_role.arn
  handler          = "test_terraform.handler"

}