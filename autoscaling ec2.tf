data "aws_availability_zones" "available" {}
# Define AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "my_aws_key" {
  key_name = "my_aws_key"
  public_key = file(var.my_public_key)
}

# Define auto scaling launch configuration
resource "aws_launch_configuration" "launch-config" {
  name_prefix   = "launch-config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_aws_key.key_name
  security_groups = [aws_security_group.instances_sg.id]
  user_data = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP= `ifconfig | grep -E '(inet addr:10)' | awk '{ print $2 }' | cut -d ':' -f 2`\necho 'Hello Cloudvests\nThis is my IP: ' $MYIP > /var/www/html/index.html"
  # user_data = "#!/bin/bash\napt-get update\napt-get install httpd -y\nchkconfig httpd on\necho $HOSTNAME > /var/www/html/index.html\nchown apache /var/www/html/index.html\n/etc/init.d/"
  lifecycle {
    create_before_destroy = true
  }
}

# Define autoscaling group 
resource "aws_autoscaling_group" "autoscaling-group" {
  name                      = "autoscaling-group"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 600
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch-config.name
  vpc_zone_identifier       = [aws_subnet.private1.id, aws_subnet.private2.id]
  load_balancers = [aws_elb.myelb.name]
  tag {
  key                 = "Name"
  value               = "my-ec2-instance"
  propagate_at_launch = true
  }
}