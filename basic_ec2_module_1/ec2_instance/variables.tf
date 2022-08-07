# --- Terraform_projects/basic_ec2_module_1/ec2_instance/variables.tf ---

variable "aws_region" {
    type     = string
    default  = "us-east-1"
}



variable "instance_type" {
    type     = string
    default  = "t2.micro"
}



