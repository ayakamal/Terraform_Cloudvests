# AWS ELB configuration
resource "aws_elb" "myelb" {
  name               = "myelb"
  subnets      = [aws_subnet.public1.id, aws_subnet.public2.id]
  security_groups = [aws_security_group.elb_sg.id]


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

   health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "myelb"
  }
} 