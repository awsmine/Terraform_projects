# PROVIDER BLOCK
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
  region = "us-east-1"
}


# VPC BLOCK

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    name = "custom_vpc"
  }
}



resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet1
  availability_zone = var.az1

  tags = {
    name = "public_subnet1"
  }
}


# public subnet 2
resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet2
  availability_zone = var.az2

  tags = {
    name = "public_subnet2"
  }
}


# private subnet 1
resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet1
  availability_zone = var.az1

  tags = {
    name = "private_subnet1"
  }
}


# private subnet 2
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet2
  availability_zone = var.az2

  tags = {
    name = "private_subnet2"
  }
}


# creating internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    name = "igw"
  }
}


# creating route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = "rt"
  }
}


# tags are not allowed here 
# associate route table to the public subnet 1
resource "aws_route_table_association" "public_rt1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rt.id
}


# tags are not allowed here 
# associate route table to the public subnet 2
resource "aws_route_table_association" "public_rt2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.rt.id
}


# tags are not allowed here 
# associate route table to the private subnet 1
resource "aws_route_table_association" "private_rt1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.rt.id
}


# tags are not allowed here 
# associate route table to the private subnet 2
resource "aws_route_table_association" "private_rt2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.rt.id
}



# SECURITY BLOCK

# create security groups for vpc (web_sg), webserver, and database

# custom vpc security group 
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "allow inbound HTTP traffic"
  vpc_id      = aws_vpc.custom_vpc.id

  # HTTP from vpc
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # outbound rules
  # internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "web_sg"
  }
}


# web tier security group
resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "allow inbound traffic from ALB"
  vpc_id      = aws_vpc.custom_vpc.id

  # allow inbound traffic from web
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "webserver_sg"
  }
}


# database security group
resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  description = "allow inbound traffic from ALB"
  vpc_id      = aws_vpc.custom_vpc.id

  # allow traffic from ALB 
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver_sg.id]
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "database_sg"
  }
}



# INSTANCES BLOCK - EC2 and DATABASE


# 1st ec2 instance on public subnet 1
resource "aws_instance" "ec2_1" {
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = var.az1
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  user_data              = file("install_apache.sh")

  tags = {
    name = "ec2_1"
  }
}

# 2nd ec2 instance on public subnet 2
resource "aws_instance" "ec2_2" {
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = var.az2
  subnet_id              = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  user_data              = file("install_apache.sh")

  tags = {
    name = "ec2_2"
  }
}



# RDS subnet group
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  tags = {
    name = "rds_subnet_g"
  }
}


# RDS database on mysql engine
resource "aws_db_instance" "my_db" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  multi_az               = false
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database_sg.id]
}



# ALB BLOCK

# # only alpha numeric and hyphen is allowed in name
# alb target group
resource "aws_lb_target_group" "external_target_g" {
  name     = "external-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.custom_vpc.id
}


resource "aws_lb_target_group_attachment" "ec2_1_target_g" {
  target_group_arn = aws_lb_target_group.external_target_g.arn
  target_id        = aws_instance.ec2_1.id
  port             = 80
}


resource "aws_lb_target_group_attachment" "ec2_2_target_g" {
  target_group_arn = aws_lb_target_group.external_target_g.arn
  target_id        = aws_instance.ec2_2.id
  port             = 80
}


# ALB
resource "aws_lb" "external_alb" {
  name               = "external-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  tags = {
    name = "external-ALB"
  }
}


# create ALB listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_target_g.arn
  }
}




# OUTPUTS

# get the DNS of the load balancer 

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.external_alb.dns_name
}

output "db_connect_string" {
  description = "MyRDS database connection string"
  value       = "server=${aws_db_instance.my_db.address}; database=ExampleDB; Uid=${var.db_username}; Pwd=${var.db_password}"
  sensitive   = true
}

