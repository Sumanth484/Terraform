variable "instance_type" {
  description = "indicates instance type"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.large"
  }
}

module "name" {
  source = "git::https://github.com/iam-veeramalla/terraform-zero-to-hero.git//Day-3/modules/ec2_instance"
  ami_value = "ami-04b70fa74e45c3917"
  instance_type_value = lookup(var.instance_type,terraform.workspace,"t2.micro")
  subnet_id_value = "subnet-0c998d52ab4da6ba6"
}
