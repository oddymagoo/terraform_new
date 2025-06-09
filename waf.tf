resource "aws_wafv2_web_acl" "waf_acl" {
  name        = "haz-waf-acl"
  description = "WAF ACL with GeoMatch and RateLimit rules"
  scope       = "REGIONAL" # Use "CLOUDFRONT" for Cloudfront, otherwise REGIONAL for ALB, API Gateway, etc.
  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "hazWAF"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "GeoMatch-Australia"
    priority = 0

    action {
      allow {}
    }

    statement {
      geo_match_statement {
        country_codes = ["AU"]
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "GeoMatchAU"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "GeoBlockNotAU"
    priority = 1

    action {
      block {}
    }

    statement {
      not_statement {
        statement {
          geo_match_statement {
            country_codes = ["AU"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "GeoBlockNotAU"
      sampled_requests_enabled   = true
    }
  }

    rule {
    name     = "AWSManagedRulesKnownBadInputs"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSKnownBadInputs"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "RateLimitPerIP"
    priority = 3

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 4000
        aggregate_key_type = "IP"
        evaluation_window  = 300
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitIP"
      sampled_requests_enabled   = true
    }
  }
}
