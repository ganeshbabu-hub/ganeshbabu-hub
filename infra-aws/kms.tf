# KMS Key for RDS Encryption
resource "aws_kms_key" "rds" {
  description         = "KMS key for RDS instance"
  enable_key_rotation = true
}