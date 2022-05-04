provider "aws" {
  region = "eu-west-1"
}
variable "server_port" {
  description = "Port number used in HTTP"
  type        = number
  default     = 8080
}
data "aws_vpc" "default" {
  default = true
}
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
# resource "aws_instance" "pierwszy" {
#   ami           = "ami-0928ce5556caf158f"
#   instance_type = "t2.micro"
#   tags = {
#     Name = "pierwszy-server"
#   }
#   vpc_security_group_ids = [aws_security_group.pierwsza_sec.id]
#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hey AWS" > index.html
#               nohup busybox httpd -f -p "${var.server_port}" &
#               EOF
# }
resource "aws_launch_configuration" "drugi" {
  image_id        = "ami-0928ce5556caf158f"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.pierwsza_sec.id]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hey AWS" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "pierwsza_sec" {
  name = "sec_group_pierwszy"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "autoscale1" {
  launch_configuration = aws_launch_configuration.drugi.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-ash-example"
    propagate_at_launch = true
  }
}

resource "aws_lb" "example" {
  name               = "terraform-asg-example"
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: didn't find"
      status_code  = 404
    }
  }
}
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}
resource "aws_lb_target_group" "asg" {
  name     = "terraform-asg-example"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_security_group" "alb" {
  name = "terraform-example-alb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "subnets"
}