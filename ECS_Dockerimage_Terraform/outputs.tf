# --- Terraform_projects/ECS_Dockerimage_Terraform/outputs.tf ---

#This will display the name of the cluster.
output "aws_ecs_cluster" {
  value       = aws_ecs_cluster.cluster.name
  description = "The name of the cluster"
}

#Compute serverless engine for ECS.
output "aws_ecs_cluster_capacity_providers" {
  value       = aws_ecs_cluster_capacity_providers.cluster.capacity_providers
  description = "Compute serverless engine for ECS"
}