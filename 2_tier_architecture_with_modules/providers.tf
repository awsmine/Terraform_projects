# --- Terraform_projects/2_tier_architecture_with_modules/providers.tf ---

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_access_key
}
