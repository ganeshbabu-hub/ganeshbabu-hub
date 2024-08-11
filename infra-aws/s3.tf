# S3 Bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = "protera-app-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "app-bucket"
  }
}
