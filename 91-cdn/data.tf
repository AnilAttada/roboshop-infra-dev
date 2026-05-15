data "aws_cloudfront_cache_policy" "cacheEnable" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_cache_policy" "cacheDisable" {
  name = "Managed-CachingDisabled"
}

data "aws_ssm_parameter" "acm_certificate_arn" {
    name = "/${var.project}/${var.environment}/acm_certificate_arn"
}