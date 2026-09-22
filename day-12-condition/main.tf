# ==========================================================
# S3 BUCKET
# ==========================================================

resource "aws_s3_bucket" "example" {

  # ========================================================
  # CONDITION
  # ========================================================
  #
  # This is a Terraform conditional expression.
  #
  # Syntax:
  #
  # condition ? value_if_true : value_if_false
  #
  # Our condition:
  #
  # var.create_bucket
  #
  # If create_bucket = true:
  #
  #       true ? 1 : 0
  #
  #       count = 1
  #
  # Terraform creates ONE S3 bucket.
  #
  #
  # If create_bucket = false:
  #
  #       false ? 1 : 0
  #
  #       count = 0
  #
  # Terraform creates ZERO S3 buckets.
  #

  count = var.create_bucket ? 1 : 0


  # ========================================================
  # BUCKET NAME
  # ========================================================
  #
  # S3 bucket names must be globally unique.
  #
  # Change this name if AWS says the name already exists.
  #

  bucket = "sameed-terraform-condition-2026-demo"


  # ========================================================
  # TAGS
  # ========================================================

  tags = {

    Name        = "Sameed Terraform Condition Bucket"
    Environment = "Dev"
  }
}


# Terraform Condition:
#
# A condition allows Terraform to make a decision based
# on whether something is TRUE or FALSE.
#
# In this example:
#
# true  -> create the S3 bucket
# false -> don't create the S3 bucket
#
# Syntax:
#
# condition ? value_if_true : value_if_false
#
# Example:
#
# var.create_bucket ? 1 : 0
#
# ==========================================================
#true → create | false → don't create.