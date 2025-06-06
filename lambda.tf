resource "aws_iam_role" "lambda_exec_role" {
  name = "helloworld_iam_role_cxv7h834njsa"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_logging" {
  name = "lambda-logging-policy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

#dynamodb = hc3_app_content_table_dev
resource "aws_lambda_function" "hello_world_function" {
  function_name = "helloworld"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename         = "${path.module}/lambda/helloworld.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/helloworld.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = "hc3_app_content_table_dev"
      #PLATFORM_ENDPOINT = "arn:aws:sns:ap-southeast-2:252152158302:app/APNS/hazchat3-prod"
    }
  }

  timeout     = 10
  memory_size = 128
}

resource "aws_lambda_event_source_mapping" "dynamodb_trigger" {
  #event_source_arn  = "arn:aws:dynamodb:ap-southeast-2:252152158302:table/hazchat-3-person-table-prod/stream/latest"
  event_source_arn                   = aws_dynamodb_table.hc3_app_content_table_dev.stream_arn
  function_name                      = aws_lambda_function.hello_world_function.arn
  starting_position                  = "LATEST"
  batch_size                         = 100
  maximum_batching_window_in_seconds = 0
  #maximum_concurrent_batches         = 1  
}
