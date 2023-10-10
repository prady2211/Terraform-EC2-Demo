terraform {
 required_providers {
  aws = {
   source =  "hashicorp/aws"
   version = "~> 4.16"
  }
 }

}  


provider "aws" { 
 region = "ap-south-1"
}


resource "aws_key_pair" "key"{
 key_name = "keypair"
 public_key = " "

}


resource "aws_default_vpc" "default_vpc" {

}



resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_default_vpc.default_vpc.id
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}



resource "aws_instance" "ec2_instance" {
 ami  = "ami-0f5ee92e2d63afc18"
 instance_type = "t2.micro"
 key_name    = aws_key_pair.key.key_name
 security_groups = [aws_security_group.allow_ssh.name]
 tags = {
  Name = "EC2_instance_terraform"
 }

}
