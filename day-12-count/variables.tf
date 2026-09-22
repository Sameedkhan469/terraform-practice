# ==========================================================
# AMI ID
# ==========================================================

variable "ami_id" {

  description = "AMI ID used for EC2 instances"

  type = string

  # Example Amazon Linux AMI.
  #
  # IMPORTANT:
  # AMI IDs are region-specific.
  # If this AMI is not available in your Mumbai region,
  # replace it with an Amazon Linux AMI from your AWS console.

  default = "ami-0f918f7e67a3323f"
}


# ==========================================================
# INSTANCE TYPE
# ==========================================================

variable "instance_type" {

  description = "EC2 instance type"

  type    = string
  default = "t3.micro"
}