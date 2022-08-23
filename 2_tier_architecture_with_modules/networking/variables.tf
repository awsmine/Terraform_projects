# --- Terraform_projects/2_tier_architecture_with_modules/networking/variables.tf ---


variable "vpc_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}

variable "availability_zones" {
  type  = list(any)
}

variable "access_ip" {
  type = string
}