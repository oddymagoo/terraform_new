resource "aws_cloudwatch_log_group" "Cloudwatch_Lambda" {
  name              = "/aws/lambda/${aws_lambda_function.hello_world_function.function_name}"
  retention_in_days = 14
}