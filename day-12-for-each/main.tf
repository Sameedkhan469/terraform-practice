# ==========================================================
# EC2 INSTANCES USING FOR_EACH
# ==========================================================

resource "aws_instance" "web" {

  # ========================================================
  # FOR_EACH
  # ========================================================
  #
  # for_each creates one resource for every value
  # in the map or set.
  #
  # Here we have 3 values:
  #
  # web1
  # web2
  # web3
  #
  # Therefore Terraform creates 3 EC2 instances.
  #

  for_each = {
    web1 = "Web-Server-1"
    web2 = "Web-Server-2"
    web3 = "Web-Server-3"
  }


  # ========================================================
  # AMI
  # ========================================================

  ami = var.ami_id


  # ========================================================
  # INSTANCE TYPE
  # ========================================================

  instance_type = var.instance_type


  # ========================================================
  # KEY PAIR
  # ========================================================
  #
  # Your previous key pair name was:
  #
  # my key
  #

  key_name = "my key"


  # ========================================================
  # TAG
  # ========================================================
  #
  # each.key gives:
  #
  # web1
  # web2
  # web3
  #
  # each.value gives:
  #
  # Web-Server-1
  # Web-Server-2
  # Web-Server-3
  #

  tags = {
    Name = each.value
  }
}


# ==========================================================
# OUTPUT
# ==========================================================

output "instance_ids" {

  description = "EC2 instance IDs"

  value = {
    for key, instance in aws_instance.web :
    key => instance.id
  }
}


output "public_ips" {

  description = "Public IP addresses of EC2 instances"

  value = {
    for key, instance in aws_instance.web :
    key => instance.public_ip
  }
}


# for_each is a Terraform meta-argument used to create
# multiple resources from a map or set of values.
#
# Unlike count, which uses numbers, for_each uses
# unique keys or values.
#
# Example:
#
# for_each = {
#   web1 = "Web-Server-1"
#   web2 = "Web-Server-2"
#   web3 = "Web-Server-3"
# }
#
# Terraform creates:
#
# web1 → Web-Server-1
# web2 → Web-Server-2
# web3 → Web-Server-3
#
# each.key   → gives the key
# each.value → gives the value
#
# ==========================================================