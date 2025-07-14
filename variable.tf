variable "aws_region" {
  description = "The AWS region to deploy resources in."
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances (Ubuntu 22.04 LTS)."
  default     = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  description = "The EC2 instance type."
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of your EC2 key pair."
  # Make sure to replace "your-key-pair-name" with your actual key pair name
  default     = "key-pair"
}
