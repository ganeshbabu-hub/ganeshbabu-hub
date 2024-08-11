# Store Database Password in AWS Parameter Store
resource "aws_ssm_parameter" "rds_password" {
  name  = "rds_password"
  type  = "SecureString"
  value = "potera123"
}
