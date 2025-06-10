resource "aws_cognito_user_pool" "hz3-user-pool" {
  /*
  account_recovery_setting {
    recovery_mechanism {
      name     = "admin_only"
      priority = "1"
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = "true"
  }

  deletion_protection = "INACTIVE"
  */

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  mfa_configuration = "OFF"
  name              = "hz3-local-user-pool"

  password_policy {
    minimum_length                   = "8"
    password_history_size            = "0"
    require_lowercase                = "true"
    require_numbers                  = "true"
    require_symbols                  = "true"
    require_uppercase                = "true"
    temporary_password_validity_days = "7"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = "false"
    mutable                  = "true"
    name                     = "address"
    required                 = "false"

    string_attribute_constraints {
      max_length = "256"
      min_length = "1"
    }
  }

  sign_in_policy {
    allowed_first_auth_factors = ["PASSWORD"]
  }


  user_pool_tier = "LITE"

  username_configuration {
    case_sensitive = "false"
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}


resource "aws_cognito_user_pool_client" "hz3_user_pool_client" {
  access_token_validity                         = "60"
  allowed_oauth_flows                           = ["code"]
  allowed_oauth_flows_user_pool_client          = "true"
  allowed_oauth_scopes                          = ["aws.cognito.signin.user.admin", "email", "openid", "profile"]
  auth_session_validity                         = "3"
  #callback_urls                                 = ["hazchat://signin"]
  enable_propagate_additional_user_context_data = "false"
  enable_token_revocation                       = "false"
  explicit_auth_flows                           = ["ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
  id_token_validity                             = "60"
  #logout_urls                                   = ["hazchat://signout"]
  name                                          = "prod"
  prevent_user_existence_errors                 = "ENABLED"
  refresh_token_validity                        = "30"
  #supported_identity_providers                  = ["A_z_u_r_e_A_D"]

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  user_pool_id = aws_cognito_user_pool.hz3-user-pool.name

}