output "ec2_public_ip" {
  value = module.ec2_instance.ec2_public_ip
}

output "my_ec2_name" {
  value = module.ec2_instance.my_ec2_name
}