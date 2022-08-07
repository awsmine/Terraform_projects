# --- Terraform_projects/basic_ec2_module_1/providers.tf ---
# --- Provider is AWS

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.23"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}
