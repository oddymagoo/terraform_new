/*
resource "aws_appsync_graphql_api" "hz3_graphql" { #Error: creating AppSync GraphQL API (hz3-graphql): operation error AppSync: CreateGraphqlApi, https response error StatusCode: 400, RequestID: d21cc9e0-1730-4a29-9e16-7c6ceb29c8de, BadRequestException: User Pool Config is empty
  api_type             = "GRAPHQL"
  authentication_type  = "AMAZON_COGNITO_USER_POOLS"
  introspection_config = "ENABLED"

  name                 = "hz3-graphql"
  query_depth_limit    = "0"
  resolver_count_limit = "0"

  visibility   = "GLOBAL"
  xray_enabled = "true"

  # This section needs to be confirmed before implementation
  log_config {
    #cloudwatch_logs_role_arn = "arn:aws:iam::340002054667:role/hazchat-3-dev-log-role"
    exclude_verbose_content  = "false"
    field_log_level          = "ERROR"
  }

  # User pool needs to be configured 
  user_pool_config {
    aws_region     = "us-west-2"
    default_action = "ALLOW"
    user_pool_id   = "us-west-2_0moF8DLkf"
  }

}


*/