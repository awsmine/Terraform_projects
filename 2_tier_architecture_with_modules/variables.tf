# --- Terraform_projects/2_tier_architecture_with_modules/variables.tf ---

variable "aws_region" {
  default = "us-east-1"
}

variable "access_ip" {
  type      = string
  sensitive = true
}

variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_access_key" {
  type      = string
  sensitive = true
}

variable "vpc_cidr" {
  description = "default vpc cidr block"
  type        = string
  default     = "10.0.0.0/16"
}



