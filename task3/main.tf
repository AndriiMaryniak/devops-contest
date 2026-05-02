
provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "andrii_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Andrii-Task3-VPC"
  }
}

resource "aws_internet_gateway" "andrii_igw" {
  vpc_id = aws_vpc.andrii_vpc.id
  tags = {
    Name = "Andrii-IGW"
  }
}

resource "aws_subnet" "public_sub" {
  vpc_id                  = aws_vpc.andrii_vpc.id
  cidr_block              = "10.50.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-Ubuntu"
  }
}

resource "aws_subnet" "private_sub" {
  vpc_id                  = aws_vpc.andrii_vpc.id
  cidr_block              = "10.50.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-Subnet-CentOS"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.andrii_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.andrii_igw.id
  }
}

resource "aws_route_table_association" "pub_assoc" {
  subnet_id      = aws_subnet.public_sub.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "ubuntu_sg" {
  name   = "ubuntu_firewall"
  vpc_id = aws_vpc.andrii_vpc.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
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

resource "aws_security_group" "centos_sg" {
  name   = "centos_firewall"
  vpc_id = aws_vpc.andrii_vpc.id

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.ubuntu_sg.id]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ubuntu_sg.id]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ubuntu_sg.id]
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ubuntu_sg.id]
  }

  egress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.ubuntu_sg.id]
  }
  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ubuntu_sg.id]
  }
  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ubuntu_sg.id]
  }
  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ubuntu_sg.id]
  }
}

data "aws_ami" "ubuntu_dynamic" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_ami" "rhel_dynamic" {
  most_recent = true
  owners      = ["309956199498"]
  filter {
    name   = "name"
    values = ["RHEL-9*x86_64*"]
  }
}

resource "aws_instance" "ubuntu_server" {
  ami                    = data.aws_ami.ubuntu_dynamic.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_sub.id
  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]
  key_name               = var.key_name
  user_data              = file("init_ubuntu.sh")
  tags = {
    Name = "Ubuntu"
  }
}

resource "aws_instance" "centos_server" {
  ami                    = data.aws_ami.rhel_dynamic.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_sub.id
  vpc_security_group_ids = [aws_security_group.centos_sg.id]
  key_name               = var.key_name
  user_data              = file("init_centos.sh")
  tags = {
    Name = "CentOS"
  }
}
