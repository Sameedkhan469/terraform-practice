# ==========================================================
# AMI ID
# ==========================================================

variable "ami_id" {

  description = "AMI ID for EC2"

  type = string

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