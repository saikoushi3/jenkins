# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Specify your desired AWS region
}

# Data source to get the latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's AWS account ID
}

# Create a security group to allow SSH and HTTP traffic
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows SSH from any IP. Restrict this to your IP in production.
  }

  ingress {
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

# Create an EC2 instance
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro" # Use a free-tier eligible instance type
  key_name      = "your-key-pair-name" # IMPORTANT: Replace with your EC2 key pair name
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "WebServer"
  }
}

# Output the public IP address of the instance
output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}
