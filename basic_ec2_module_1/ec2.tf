# --- Terraform_projects/basic_ec2_module_1/ec2.tf ---

module "ec2_instance" {
  source = "./ec2_instance"
}