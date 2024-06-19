variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-west-2"  # Change this to your preferred region
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # This is an Amazon Linux 2 AMI in us-west-2 region; change it based on your region
}

