# ==========================================================
# BOOLEAN VARIABLE
# ==========================================================

variable "create_bucket" {

  # This variable decides whether Terraform should
  # create the S3 bucket or not.

  description = "Create S3 bucket or not"

  # bool means this variable can have only two values:
  #
  # true
  # false

  type = bool

  # TRUE means:
  # Terraform WILL create the bucket.

  default = true
}