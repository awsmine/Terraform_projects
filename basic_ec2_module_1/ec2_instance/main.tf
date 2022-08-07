# --- Terraform_projects/basic_ec2_module_1/ec2_instance/main.tf ---
# --- used this link to get information for aws_ami ---
# --- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance ---

data "aws_ami" "linux" {
   most_recent = true
   owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_instance" "my_ec2" {
  ami                = data.aws_ami.linux.id
  instance_type      = var.instance_type

  tags = {
    Name = "my_ec2"
  }
}

