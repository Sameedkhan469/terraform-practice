# --------------------------------------------------
# SECURITY GROUP
# --------------------------------------------------

resource "aws_security_group" "provisioner_sg" {

  name        = "terraform-provisioner-sg"
  description = "Security group for Terraform provisioner demo"

  # Allow SSH from your IP.
  # For a lab, you can temporarily use 0.0.0.0/0,
  # but restricting SSH to your own IP is safer.
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP.
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# --------------------------------------------------
# EC2 INSTANCE
# --------------------------------------------------

resource "aws_instance" "provisioner_ec2" {

  # AMI used to create EC2.
  ami = var.ami_id

  # EC2 instance type.
  instance_type = var.instance_type

  # AWS key pair used for SSH.
  key_name = var.key_name

  # Attach security group.
  vpc_security_group_ids = [
    aws_security_group.provisioner_sg.id
  ]

  # ------------------------------------------------
  # REMOTE-EXEC PROVISIONER
  # ------------------------------------------------
  #
  # This runs commands INSIDE the EC2 instance.
  #
  # Terraform first creates the EC2.
  # Then Terraform connects to the EC2 using SSH.
  # Then these commands are executed.
  #

  provisioner "remote-exec" {

    inline = [

      # Update packages.
      "sudo dnf update -y",

      # Install Docker.
      "sudo dnf install docker -y",

      # Start Docker service.
      "sudo systemctl start docker",

      # Enable Docker after reboot.
      "sudo systemctl enable docker",

      # Add ec2-user to docker group.
      "sudo usermod -aG docker ec2-user",

      # Check Docker installation.
      "docker --version"
    ]

    # ------------------------------------------------
    # SSH CONNECTION
    # ------------------------------------------------
    #
    # Terraform needs this information to connect
    # to the EC2 instance.
    #

    connection {

      # EC2 Linux username.
      type = "ssh"
      user = "ec2-user"

      # Public IP of the EC2.
      host = self.public_ip

      # Location of your private key.
      #
      # IMPORTANT:
      # Change this path to where your .pem file exists.
      #
      private_key = file("C:/Users/admin/Downloads/my key.pem")

      # SSH port.
      port = 22
    }
  }

  # ------------------------------------------------
  # LOCAL-EXEC PROVISIONER
  # ------------------------------------------------
  #
  # This command runs on YOUR COMPUTER,
  # not inside the EC2.
  #

  provisioner "local-exec" {

    command = "echo EC2 created with public IP ${self.public_ip}"
  }

  tags = {
    Name = "Terraform-Provisioner-EC2"
  }
}


# --------------------------------------------------
# OUTPUT
# --------------------------------------------------

#output "ec2_public_ip" {

 # description = "Public IP address of EC2"

  #value = aws_instance.provisioner_ec2.public_ip


#A Terraform provisioner is used to execute commands or scripts during resource creation or destruction. There are two types of provisioners: `remote-exec` and `local-exec`. The `remote-exec` provisioner runs commands on the remote resource (e.g., an EC2 instance), while the `local-exec` provisioner runs commands on the local machine where Terraform is executed.
#remote-exec executes commands on a remote resource such as an EC2 instance.
#local-exec executes commands on the machine where Terraform is running.

#| Provisioner   | Where does it run? | Example        |
#| ------------- | ------------------ | -------------- |
#| `remote-exec` | EC2                | Install Docker |
#| `local-exec`  | Your PC            | Print EC2 IP   |



#remote-exec — VERY IMPORTANT

#This is the main provisioner you're learning.

#provisioner "remote-exec" {

#Remote = EC2

#It means:

#"Run these commands inside the EC2."

#Your commands are:

#"sudo dnf update -y"
#"sudo dnf install docker -y"
#"sudo systemctl start docker"
#"sudo systemctl enable docker"

#So Terraform creates the EC2 and then does:

#EC2 created
    #↓
#SSH into EC2
   # ↓
#Update packages
   # ↓
#Install Docker
   # ↓
#Start Docker
#Easy memory trick:

#REMOTE-EXEC → REMOTE machine → EC2