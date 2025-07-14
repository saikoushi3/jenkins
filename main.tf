# Configure the AWS provider
provider "aws" {
  region = var.aws_region # Specify your desired AWS region
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
    from_port   = 8080
    to_port     = 8080
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
resource "aws_instance" "jenkins_server" {
  ami           = var.ami_id
  instance_type = var.instance_type # Use a free-tier eligible instance type
  key_name      = "key-pair" # IMPORTANT: Replace with your EC2 key pair name
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "jenkins"
  }
}
