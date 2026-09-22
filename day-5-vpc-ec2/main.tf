# ==========================================================
# TERRAFORM AWS VPC + EC2 PROJECT
# ==========================================================
#
# This project creates:
#
# 1. VPC
# 2. Subnet
# 3. Internet Gateway
# 4. Route Table
# 5. Route Table Association
# 6. Security Group
# 7. EC2 Instance
#
# ==========================================================


# ==========================================================
# VPC
# ==========================================================
#
# VPC = Virtual Private Cloud
#
# A VPC is a private network inside AWS.
#
# CIDR:
#
# 10.0.0.0/16
#
# gives us a large private IP address range.
#

resource "aws_vpc" "sam" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sam-vpc"
  }
}


# ==========================================================
# SUBNET
# ==========================================================
#
# A subnet is a smaller network inside the VPC.
#
# Our VPC:
#
# 10.0.0.0/16
#
# Our subnet:
#
# 10.0.1.0/24
#
# The subnet is created INSIDE the VPC.
#
# vpc_id tells AWS which VPC this subnet belongs to.
#

resource "aws_subnet" "sam_subnet" {

  vpc_id = aws_vpc.sam.id

  cidr_block = "10.0.1.0/24"

  # This allows instances launched in this subnet
  # to receive a public IPv4 address automatically.
  #
  # This is useful for our public EC2 lab.

  map_public_ip_on_launch = true

  tags = {
    Name = "sam-subnet"
  }
}


# ==========================================================
# INTERNET GATEWAY
# ==========================================================
#
# Internet Gateway (IGW) allows communication between
# the VPC and the Internet.
#
# The IGW is attached to our VPC.
#

resource "aws_internet_gateway" "sam_igw" {

  vpc_id = aws_vpc.sam.id

  tags = {
    Name = "sam-igw"
  }
}


# ==========================================================
# ROUTE TABLE
# ==========================================================
#
# A route table controls where network traffic goes.
#
# This route:
#
# 0.0.0.0/0
#
# means:
#
# "Any destination on the Internet."
#
# gateway_id points that traffic to our Internet Gateway.
#

resource "aws_route_table" "sam_route_table" {

  vpc_id = aws_vpc.sam.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.sam_igw.id
  }

  tags = {
    Name = "sam-route-table"
  }
}


# ==========================================================
# ROUTE TABLE ASSOCIATION
# ==========================================================
#
# Creating a route table is not enough.
#
# We need to associate it with our subnet.
#
# This means:
#
# sam-subnet
#      ↓
# sam-route-table
#      ↓
# Internet Gateway
#      ↓
# Internet
#

resource "aws_route_table_association" "sam_route_table_assoc" {

  subnet_id = aws_subnet.sam_subnet.id

  route_table_id = aws_route_table.sam_route_table.id
}


# ==========================================================
# SECURITY GROUP
# ==========================================================
#
# A Security Group acts like a virtual firewall for
# AWS resources such as EC2.
#
# It controls inbound and outbound traffic.
#

resource "aws_security_group" "sam_sg" {

  name = "sam-sg"

  description = "Allow HTTP and SSH"

  vpc_id = aws_vpc.sam.id


  # ========================================================
  # SSH
  # ========================================================
  #
  # Port 22 is used for SSH.
  #
  # SSH allows us to connect to the Linux EC2 instance.
  #
  # For a real environment, restrict this to your IP.
  #

  ingress {

    description = "SSH"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }


  # ========================================================
  # HTTP
  # ========================================================
  #
  # Port 80 is used for HTTP.
  #
  # This allows web traffic from the Internet.
  #

  ingress {

    description = "HTTP from Internet"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }


  # ========================================================
  # OUTBOUND TRAFFIC
  # ========================================================
  #
  # -1 means all protocols.
  #
  # 0.0.0.0/0 means anywhere.
  #
  # Therefore the EC2 can send outbound traffic anywhere.
  #

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sam-sg"
  }
}


# ==========================================================
# EC2 INSTANCE
# ==========================================================
#
# This creates our Linux EC2 instance.
#
# The EC2 will be placed inside our subnet.
#

resource "aws_instance" "sam_instance" {


  # ========================================================
  # AMI
  # ========================================================
  #
  # AMI = Amazon Machine Image
  #
  # It defines the operating system/image used by EC2.
  #
  # IMPORTANT:
  # AMI IDs are region-specific.
  # Replace this with a valid Amazon Linux AMI
  # available in your selected region if necessary.
  #

  ami = "ami-090d68841c2a28756"


  # ========================================================
  # INSTANCE TYPE
  # ========================================================
  #
  # t3.micro defines the size of the EC2 instance.
  #

  instance_type = "t3.micro"


  # ========================================================
  # KEY PAIR
  # ========================================================
  #
  # The key pair is used to connect to the EC2 through SSH.
  #
  # Your key pair name:
  #
  # my key
  #

  key_name = "my key"


  # ========================================================
  # SUBNET
  # ========================================================
  #
  # This places the EC2 inside our subnet.
  #

  subnet_id = aws_subnet.sam_subnet.id


  # ========================================================
  # SECURITY GROUP
  # ========================================================
  #
  # Attach our security group to the EC2.
  #

  vpc_security_group_ids = [
    aws_security_group.sam_sg.id
  ]


  # ========================================================
  # TAG
  # ========================================================

  tags = {
    Name = "sam-instance"
  }
}


# ==========================================================
# SIMPLE INTERVIEW DEFINITIONS
# ==========================================================
#
# VPC:
# A VPC is an isolated virtual network in AWS where
# we can launch AWS resources.
#
#
# SUBNET:
# A subnet is a smaller network inside a VPC.
#
#
# INTERNET GATEWAY:
# An Internet Gateway provides a path between a VPC
# and the Internet.
#
#
# ROUTE TABLE:
# A route table contains rules that determine where
# network traffic should go.
#
#
# ROUTE TABLE ASSOCIATION:
# It connects a subnet with a route table.
#
#
# SECURITY GROUP:
# A security group is a virtual firewall that controls
# inbound and outbound traffic for resources such as EC2.
#
#
# EC2:
# EC2 is a virtual server provided by AWS.
#
#
# ==========================================================
# COMPLETE TRAFFIC FLOW
# ==========================================================
#
# Internet
#     ↓
# Internet Gateway
#     ↓
# Route Table
#     ↓
# Subnet
#     ↓
# Security Group
#     ↓
# EC2
#
# This Terraform configuration creates an AWS VPC with
# a subnet, Internet Gateway, route table, security group,
# and EC2 instance, allowing the EC2 to communicate with
# the Internet.
#
# ==========================================================