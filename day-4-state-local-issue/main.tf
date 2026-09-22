# ==========================================================
# DAY-4: LOCAL STATE ISSUE
# ==========================================================
#
# This example demonstrates the problem with Terraform
# LOCAL STATE when multiple people work on the same project.
#
# ==========================================================


# ==========================================================
# S3 BUCKET
# ==========================================================
#
# This creates an S3 bucket.
#
# Terraform will store information about this resource
# in the local terraform.tfstate file.
#

resource "aws_s3_bucket" "sam_bucket" {

  bucket = "sam-local-state-issue-2026-unique"

  tags = {

    Name        = "sam-local-state-issue"

    Environment = "Learning"

    Project     = "Terraform-Local-State"
  }
}


# ==========================================================
# OUTPUT
# ==========================================================
#
# This displays the bucket name after terraform apply.
#

output "bucket_name" {

  value = aws_s3_bucket.sam_bucket.bucket
}


# ==========================================================
# LOCAL STATE
# ==========================================================
#
# By default, Terraform stores its state locally:
#
# terraform.tfstate
#
# Example:
#
# Developer 1
#      ↓
# terraform.tfstate
#
# Developer 2
#      ↓
# another terraform.tfstate
#
#
# If two developers are working on the same infrastructure
# from different computers, they can have different local
# state files.
#
# This can create problems such as:
#
# 1. State files can become different.
# 2. Team members may not see the latest state.
# 3. Two people can modify infrastructure at the same time.
# 4. State can be lost if the local machine is lost.
# 5. Collaboration becomes difficult.
#
#
# ==========================================================
# SIMPLE EXAMPLE
# ==========================================================
#
# Developer A:
#
# Computer A
#     ↓
# terraform.tfstate
#
#
# Developer B:
#
# Computer B
#     ↓
# terraform.tfstate
#
#
# These are two separate local state files.
#
# They are NOT automatically synchronized.
#
#
# ==========================================================
# SOLUTION
# ==========================================================
#
# For team environments, Terraform can use a REMOTE BACKEND.
#
# Example:
#
# Developer A
#       \
#        \
#         → Remote State
#        /
#       /
# Developer B
#
# AWS S3 can be used to store the Terraform state remotely.
#
# ==========================================================
#
#  DEFINITION:
#
# "Local state means Terraform stores the state file on the
# local machine. It is simple for individual practice, but
# it can create collaboration and synchronization problems
# when multiple team members work on the same infrastructure."
#
# ==========================================================