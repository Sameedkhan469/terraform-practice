# This is a sample Terraform configuration to create an AWS VPC.
resource "aws_vpc" "sam" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "sam-vpc"
  }
}
# create a subnet in the VPC
resource "aws_subnet" "sam_subnet" {
  vpc_id            = aws_vpc.sam.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "sam-subnet"
  }
}   
#create an internet gateway for the VPC
resource "aws_internet_gateway" "sam_igw" {
  vpc_id = aws_vpc.sam.id
  tags = {
    Name = "sam-igw"
  }
}
#create a route table and edit the route table to point to the internet gateway
resource "aws_route_table" "sam_route_table" {
  vpc_id = aws_vpc.sam.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.sam_igw.id
    }
}
#associate the route table with the subnet
resource "aws_route_table_association" "sam_route_table_assoc" {
  subnet_id      = aws_subnet.sam_subnet.id
  route_table_id = aws_route_table.sam_route_table.id
}
#create a security group for the VPC
resource "aws_security_group" "sam_sg" {
  name        = "sam-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.sam.id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance in the subnet

resource "aws_instance" "sam_instance" {

  ami           = "ami-090d68841c2a28756" # Amazon Linux 2 AMI

  instance_type = "t3.micro"

  key_name      = "my key"

  subnet_id     = aws_subnet.sam_subnet.id

  vpc_security_group_ids = [aws_security_group.sam_sg.id]

  tags = {
    Name = "sam-instance"
  }
}