# Enable CloudTrail for Auditing and Logging API Calls
resource "aws_cloudtrail" "main" {
  name                          = "main-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.app_bucket.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true
}