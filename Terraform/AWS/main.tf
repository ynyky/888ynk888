provider "aws" {
    region = "eu-west-1"
}
variable "server_port" {
  description = "Port number used in HTTP"
  type = number
  default = 8080
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
  image_id           = "ami-0928ce5556caf158f"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.pierwsza_sec.id]
  user_data = <<-EOF
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
    from_port = var.server_port
    to_port   = var.server_port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}

resource "aws_autoscaling_group" "autoscale1" {
  launch_configuration = aws_launch_configuration.drugi.name
  vpc_zone_identifier = data.aws_subnet_ids.default.ids

  min_size = 2
  max_size = 10

  tag {
    key = "Name"
    value = "terraform-ash-example"
    propagate_at_launch = true
  }
}

output "aws_subnets_ids" {
  value = data.aws_subnet_ids.default.ids
  description = "subnets"
}