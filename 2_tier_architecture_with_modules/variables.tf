# --- Terraform_projects/2_tier_architecture_with_modules/variables.tf ---

variable "aws_region" {
  default = "us-east-1"
}

variable "access_ip" {
  type = string
  sensitive = true
}