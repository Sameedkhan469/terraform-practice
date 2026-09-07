resource "aws_s3_bucket" "my_bucket" {
  bucket = "sameed-terraform-s3-demo-2026-12345"

  tags = {
    Name        = "Terraform S3 Bucket"
    Environment = "Dev"
  }
}