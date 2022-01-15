# Security group for AWS ELB
resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "Security group for elb"
  vpc_id      = aws_vpc.myvpc.id

  ingress = [
    {
      description = ""
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    },
  ]
  egress = [
    {
      description = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]
  
}

# Security group for instances
resource "aws_security_group" "instances_sg" {
  name        = "instances_sg"
  description = "Security group for instances"
  vpc_id      = aws_vpc.myvpc.id

  ingress = [
    {
      description = ""
      from_port        = 22
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = [aws_security_group.elb_sg.id]
      self = false
    },
  ]
  egress = [
    {
      description = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]
}