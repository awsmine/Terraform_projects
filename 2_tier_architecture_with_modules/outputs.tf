# --- Terraform_projects/2_tier_architecture_with_modules/outputs.tf ---


output "alb_dns" {
  value = module.loadbalancing.alb_dns
}

