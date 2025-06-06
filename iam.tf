resource "aws_iam_role_policy" "lambda_dynamodb_stream" {
  name = "lambda-dynamodb-stream-policy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetRecords",
          "dynamodb:GetShardIterator",
          "dynamodb:DescribeStream",
          "dynamodb:ListStreams"
        ],
        Resource = aws_dynamodb_table.hc3_app_content_table_dev.stream_arn
      }
    ]
  })
}
