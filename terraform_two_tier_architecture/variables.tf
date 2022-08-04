# custom VPC variable
variable "vpc_cidr" {
  description = "custom vpc CIDR notation"
  type        = string
  default     = "10.0.0.0/16"
}


# public subnet 1 variable
variable "public_subnet1" {
  description = "public subnet 1 CIDR notation"
  type        = string
  default     = "10.0.1.0/24"
}


# public subnet 2 variable
variable "public_subnet2" {
  description = "public subnet 2 CIDR notation"
  type        = string
  default     = "10.0.2.0/24"
}


# private subnet 1 variable
variable "private_subnet1" {
  description = "private subnet 1 CIDR notation"
  type        = string
  default     = "10.0.3.0/24"
}


# private subnet 2 variable
variable "private_subnet2" {
  description = "private subnet 2 CIDR notation"
  type        = string
  default     = "10.0.4.0/24"
}


# AZ 1
variable "az1" {
  description = "availability zone 1"
  type        = string
  default     = "us-east-1a"
}


# AZ 2
variable "az2" {
  description = "availability zone 2"
  type        = string
  default     = "us-east-1b"
}


# ec2 instance ami for Linux
variable "ec2_instance_ami" {
  description = "ec2 instance ami id"
  type        = string
  default     = "ami-090fa75af13c156b4"
}


# ec2 instance type
variable "ec2_instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}


# db engine
variable "db_engine" {
  description = "db engine"
  type        = string
  default     = "mysql"
}


# db engine version
variable "db_engine_version" {
  description = "db engine version"
  type        = string
  default     = "5.7"
}


# db name
variable "db_name" {
  description = "db name"
  type        = string
  default     = "my_db"
}


# db instance class
variable "db_instance_class" {
  description = "db instance class"
  type        = string
  default     = "db.t2.micro"
}


# database username variable
variable "db_username" {
  description = "database admin username"
  type        = string
  sensitive   = true
}


# database password variable
variable "db_password" {
  description = "database admin password"
  type        = string
  sensitive   = true
}

