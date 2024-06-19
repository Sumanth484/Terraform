output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.example.private_ip
}

output "instance_ami" {
  description = "The AMI used for the EC2 instance"
  value       = aws_instance.example.ami
}

output "instance_type" {
  description = "The type of the EC2 instance"
  value       = aws_instance.example.instance_type
}

output "instance_availability_zone" {
  description = "The availability zone of the EC2 instance"
  value       = aws_instance.example.availability_zone
}

