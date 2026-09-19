module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.0"

  bucket = "sameed-day9-terraform-demo-2026"

  versioning = {
    enabled = true
  }

  tags = {
    Name        = "Day9-S3"
    Environment = "dev"
  }
}