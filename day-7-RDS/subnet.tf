resource "aws_db_subnet_group" "default" {
  name = "mydb-subnet-group"

 subnet_ids = [
  "subnet-0123456789abcdef0",
  "subnet-0987654321abcdef0"
]

  tags = {
    Name = "My DB Subnet Group"
  }
}