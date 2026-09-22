# ==========================================================
# TERRAFORM PROVIDER
# ==========================================================

terraform {

  # AWS provider is required to create AWS resources.
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


# ==========================================================
# AWS PROVIDER
# ==========================================================

provider "aws" {

  # AWS Mumbai region
  region = "ap-south-1"
}