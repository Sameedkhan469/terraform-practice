resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc_dhcp_options" "example" {
  domain_name = "example.com"

  depends_on = [
    aws_vpc.main
  ]
}
module "vpc" {
  source = "./modules/vpc"
}