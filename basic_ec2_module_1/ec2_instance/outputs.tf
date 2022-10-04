# --- Terraform_projects/basic_ec2_module_1/ec2_instance/outputs.tf ---

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "my_ec2_name" {
  value = aws_instance.my_ec2.tags_all.Name
}