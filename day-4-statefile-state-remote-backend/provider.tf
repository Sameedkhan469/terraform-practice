# ============================================================
# PROVIDER FILE
# ============================================================
# This file tells Terraform which cloud provider we are using.
# Here we are using AWS.
#
# REGION:
# ap-south-1 = Mumbai
# ============================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# ============================================================
# DEFINITION:
#
# Provider:
# A provider is a plugin that allows Terraform to communicate
# with a cloud platform or other service.
#
# Example:
# AWS provider -> Terraform can create AWS resources.
# ============================================================