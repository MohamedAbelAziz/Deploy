provider "aws" {
  region = "eu-north-1"
}

#resource "aws_instance" "terraform_inst" {
#  ami           = "ami-0129bfde49ddb0ed6"
#  instance_type = "t3.micro"
#  count = 2
#  tags = {
#    Name = "terraform_inst"
#  }
#}

resource "aws_instance" "web" {
  ami             = "ami-04cdc91e49cb06165"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.Terraform_SG.name]
  count           = 2
  tags = {
    Name = "Terraform EC2-${count.index + 1}"
  }
}

#securitygroup using Terraform

resource "aws_security_group" "Terraform_SG" {
  name        = "security_TF"
  description = "security_TF"
  vpc_id      = "vpc-0df7caa371ebb115d"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Terraform_SG"
  }
}