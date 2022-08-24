# --- Terraform_projects/2_tier_architecture_with_modules/loadbalancing/variables.tf ---

variable "public_subnet" {}
variable "vpc_id" {}
variable "web_sg" {}
variable "database_asg" {}

variable "tg_protocol" {
  default = "HTTP"
}

variable "tg_port" {
  default = 80
}

variable "listener_protocol" {
  default = "HTTP"
}

variable "listener_port" {
  default = 80
}