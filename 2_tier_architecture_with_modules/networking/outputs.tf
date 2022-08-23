# --- Terraform_projects/2_tier_architecture_with_modules/networking/outputs.tf ---

output "vpc_id" {
    value= aws_vpc.my_vpc.id
}

output "public_sg" {
  value = aws_security_group.my_public_sg.id
}

output "private_sg" {
  value = aws_security_group.my_private_sg.id
}

output "web_sg" {
  value = aws_security_group.my_web_sg.id
}

output "private_subnet" {
  value = aws_subnet.my_private_subnet[*].id
}

output "public_subnet" {
  value = aws_subnet.my_public_subnet[*].id
}