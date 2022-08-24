# --- Terraform_projects/2_tier_architecture_with_modules/loadbalancing/outputs.tf ---


output "alb_tg" {
  value = aws_lb_target_group.my_tg.arn
}

output "alb_dns" {
  value = aws_lb.my_lb.dns_name
}