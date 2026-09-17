resource "aws_db_instance" "default" {
  allocated_storage = 10

  db_name  = "mydb"
  engine   = "mysql"
  username = "admin"
  password = "sam@1234"

  engine_version = "8.0"
  instance_class = "db.t3.micro"

  db_subnet_group_name = aws_db_subnet_group.default.name

  skip_final_snapshot = true
}