# Define RDS DB
resource "aws_db_instance" "my_rds" {
  identifier             = "my-rds"
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "11.10"
  instance_class       = "db.t2.micro"
  username             = "terraform_rds"
  password             = var.password
  parameter_group_name = aws_db_parameter_group.rds_parameter_gp.name
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_gp.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
}

# The parameter group resource contains all of the database-level settings for your RDS instance, 
resource "aws_db_parameter_group" "rds_parameter_gp" {
  name   = "rds-parameter-gp"
  family = "postgres11"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

# Creates RDS in My VPC private subnets region
resource "aws_db_subnet_group" "rds_subnet_gp" {
  name       = "rds-subnet-gp"
  subnet_ids = [aws_subnet.private1.id,aws_subnet.private2.id]

  tags = {
    Name = "rds-subnet-gp"
  }
}

# Define security group for traffic to RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow connectivity from VPC"
  vpc_id      = aws_vpc.myvpc.id

  ingress = [
    {
      description      = "Allow connectivity from VPC"
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.myvpc.cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self = false
    }
  ]
  egress = [
    {
      description = ""
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.myvpc.cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]
}

  
