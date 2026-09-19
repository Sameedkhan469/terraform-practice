module "ec2" {
  source = "./modules/ec2"

  ami_id        = "ami-0f918f7e67a3323f0"
  instance_type = "t3.micro"
  instance_name = "day9-child-module-ec2"
}