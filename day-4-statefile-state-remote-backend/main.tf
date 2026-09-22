# ============================================================
# S3 BUCKET FOR TERRAFORM REMOTE STATE
# ============================================================
# This bucket will store the Terraform state file.
#
# IMPORTANT:
# The bucket name must be globally unique.
# ============================================================

resource "aws_s3_bucket" "terraform_state" {

  bucket = "sam-remote-state-backend-2026-unique"

  tags = {
    Name        = "Sam Terraform Remote State"
    Environment = "Learning"
  }
}

# ============================================================
# ENABLE VERSIONING
# ============================================================
# Versioning keeps previous versions of objects in the bucket.
#
# For a state file, this can help recover an older version if
# the current state is accidentally changed or deleted.
# ============================================================

resource "aws_s3_bucket_versioning" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ============================================================
# OUTPUT
# ============================================================
# This prints the S3 bucket name after Terraform apply.
# ============================================================

output "bucket_name" {

  value = aws_s3_bucket.terraform_state.bucket
}

# ============================================================
# SIMPLE DEFINITION:
#
# Remote Backend:
# A remote backend stores Terraform's state file in a remote
# location instead of storing it only on your local computer.
#
# Example:
#
# Local State:
# Computer
#    └── terraform.tfstate
#
# Remote State:
# AWS S3
#    └── terraform.tfstate
#
# S3 is commonly used as a remote backend for Terraform.
# ============================================================