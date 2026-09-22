# ==========================================================
# TERRAFORM CONFIGURATION
# ==========================================================

terraform {

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

  # Mumbai region
  region = "ap-south-1"
}