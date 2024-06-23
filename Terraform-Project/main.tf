resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

   tags = {
    Name = "mysubnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "mysubnet2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "mygateway"
  }
}

resource "aws_route_table" "myroutetable" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "192.0.0.0/22"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "RTA1" {
  route_table_id = aws_route_table.myroutetable.id
  subnet_id = aws_subnet.subnet1.id
}

resource "aws_route_table_association" "RTA2" {
  route_table_id = aws_route_table.myroutetable.id
  subnet_id = aws_subnet.subnet2.id
}

resource "aws_security_group" "loadsg" {
  name = "sgload"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

}

resource "aws_security_group" "mysg" {
  name   = "sgweb"
  vpc_id = aws_vpc.myvpc.id

   ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group_rule" "allow_ingress_from_sg" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.mysg.id

  source_security_group_id = aws_security_group.loadsg.id
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "kp" {
  key_name = "sample"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "privatekey" {
  content = tls_private_key.key.private_key_pem
  filename = "./sample.pem"
}


resource "aws_instance" "web1" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id = aws_subnet.subnet1.id
  key_name = aws_key_pair.kp.key_name

  tags ={
    Name = "server1"
  }
}

resource "aws_instance" "web2" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id = aws_subnet.subnet2.id
  key_name = aws_key_pair.kp.key_name
  

  tags ={
    Name = "server2"
  }
}

resource "aws_lb" "myalb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.loadsg.id]
  subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = {
    Name = "weblb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "tga1" {
  target_group_arn = aws_lb_target_group.tg.id
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tga2" {
  target_group_arn = aws_lb_target_group.tg.id
  target_id        = aws_instance.web2.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}

output "loadbalancerdns" {
  value = aws_lb.myalb.dns_name
}