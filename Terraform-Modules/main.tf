
module "ec2_instance" {
  source = "git::https://github.com/iam-veeramalla/terraform-zero-to-hero.git//Day-3/modules/ec2_instance"
  ami_value = "ami-04b70fa74e45c3917"
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-0c998d52ab4da6ba6"
}