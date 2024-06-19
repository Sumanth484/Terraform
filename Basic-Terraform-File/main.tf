terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"  # Change this to your preferred region
}

resource "aws_instance" "Terraform-example" {
  ami           = "ami-0f2e255ec956ade7f"  # This is an Ubuntu AMI in us-west-2 region; change it based on your region
  instance_type = "t2.micro"               # Change this to the instance type you need

  tags = {
    Name = "Sample-Instance-Terraform"
  }
}

