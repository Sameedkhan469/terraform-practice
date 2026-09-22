# ==========================================================
# DAY-4: TERRAFORM LOCAL STATE ISSUE
# ==========================================================
#
# PROVIDER:
# A provider is a plugin that allows Terraform to communicate
# with AWS APIs.
#
# Here we are using the AWS provider.
#
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
#
# ap-south-1 = Mumbai region
#

provider "aws" {

  region = "ap-south-1"
}


# ==========================================================
# DEFINITION
# ==========================================================
#
# Provider:
#
# "A Terraform provider is a plugin that allows Terraform
# to interact with APIs of cloud platforms and services."
#
# ==========================================================