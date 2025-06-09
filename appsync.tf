resource "aws_appsync_graphql_api" "hz3-graphql" {
  api_type             = "GRAPHQL"
  authentication_type  = "AMAZON_COGNITO_USER_POOLS"
  introspection_config = "ENABLED"
  /*
  log_config {
    #cloudwatch_logs_role_arn = "arn:aws:iam::340002054667:role/hazchat-3-dev-log-role"
    exclude_verbose_content  = "false"
    field_log_level          = "ERROR"
  }
*/
  name                 = "hz3-graphql"
  query_depth_limit    = "0"
  resolver_count_limit = "0"


  /*
  user_pool_config {
    aws_region     = "us-west-2"
    default_action = "ALLOW"
    user_pool_id   = "us-west-2_0moF8DLkf"
  }
*/

  visibility   = "GLOBAL"
  xray_enabled = "true"
}