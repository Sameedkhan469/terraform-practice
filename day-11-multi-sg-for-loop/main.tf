resource "aws_security_group" "for_loop_sg" {

  name        = "terraform-for-loop-sg"
  description = "Security group created using for loop"

  # Create one ingress rule for every port
  # inside the ports list.
  dynamic "ingress" {

    for_each = var.ports

    content {

      description = "Allow port ${ingress.value}"

      from_port = ingress.value
      to_port   = ingress.value

      protocol = "tcp"

      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Allow outbound traffic
  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "For-Loop-Security-Group"
  }
}