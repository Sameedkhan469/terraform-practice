# ==========================================================
# EC2 INSTANCES USING COUNT
# ==========================================================

resource "aws_instance" "web" {

  # ========================================================
  # COUNT
  # ========================================================
  #
  # count tells Terraform how many copies of a resource
  # should be created.
  #
  # Here:
  #
  # count = 3
  #
  # Terraform creates THREE EC2 instances.
  #
  # Terraform automatically gives each instance an index:
  #
  # aws_instance.web[0]
  # aws_instance.web[1]
  # aws_instance.web[2]
  #
  # Index starts from ZERO.
  #
  # Therefore:
  #
  # [0] = First EC2
  # [1] = Second EC2
  # [2] = Third EC2
  #

  count = 3


  # ========================================================
  # AMI
  # ========================================================
  #
  # All three EC2 instances use the same AMI.
  #

  ami = var.ami_id


  # ========================================================
  # INSTANCE TYPE
  # ========================================================
  #
  # All three instances use t3.micro.
  #

  instance_type = var.instance_type


  # ========================================================
  # KEY PAIR
  # ========================================================
  #
  # Replace with the key pair that exists in your AWS account.
  #
  # Your key pair name from your previous lab was:
  #
  # my key
  #

  key_name = "my key"


  # ========================================================
  # TAG
  # ========================================================
  #
  # count.index gives the number of the current instance.
  #
  # First instance:
  # count.index = 0
  #
  # Second instance:
  # count.index = 1
  #
  # Third instance:
  # count.index = 2
  #
  # Therefore the names become:
  #
  # Web-Server-1
  # Web-Server-2
  # Web-Server-3
  #

  tags = {

    Name = "Web-Server-${count.index + 1}"
  }
}


# ==========================================================
# OUTPUT
# ==========================================================

output "instance_ids" {

  description = "IDs of all three EC2 instances"

  value = aws_instance.web[*].id
}


output "public_ips" {

  description = "Public IP addresses of all three EC2 instances"

  value = aws_instance.web[*].public_ip
}


# count is a Terraform meta-argument used to create
# multiple instances of the same resource.
#
# Example:
#
# count = 3
#
# means Terraform creates 3 copies of that resource.
#
# Terraform gives every copy an index starting from 0:
#
# resource[0]
# resource[1]
# resource[2]
#
# count.index gives the index of the current resource.
#
# ==========================================================