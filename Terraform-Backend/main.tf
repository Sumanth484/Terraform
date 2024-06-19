resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "Example-Terraform-Instance"
  }
}

resource "aws_s3_bucket" "s3_statefile" {
  bucket = "statefile-storage-s3-sumanth"
}
