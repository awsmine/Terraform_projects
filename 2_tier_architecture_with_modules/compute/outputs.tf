# --- Terraform_projects/2_tier_architecture_with_modules/compute/outputs.tf ---

output "database_asg" {
  value = aws_autoscaling_group.my_database
}