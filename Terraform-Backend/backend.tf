terraform {
  backend "s3" {
    bucket         = "statefile-storage-s3-sumanth"
    key            = "terraform.tfstate"
    region         = "us-west-2"
  }
}
