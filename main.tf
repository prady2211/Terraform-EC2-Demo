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
 public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDI+VRr67cynVngSAk594H/Z4SeOZ5EPq00rba+0TD+iA98/0Vnnlx9COTQdVoxfK9zRc6ME6KLB50zwtjffObRgDMxkle9c8gNpjIfRFogb8P9IUEVMJ34XJZSmMrhq58Vrq36iIfs5miYxp3GZYkQakFfs74EbAWeJIdkRhZ+xOZCTJISalV5zOVEge4ijXUvyzlssZf6NsUnlfblZAeY2GxBqN+Mt7+zAczgEWOPY+fV8FToOl30pU8ECJlJvJBcKYx2HU3RZXobLap5NFg+Tlo1duZAk1U9w6Jw0zuwrNGEBYC+4EQTGzTtRPrnFfr1B7ygwHl8zAxFdXmshMGaiuEhg60WDr7goe7OT68ADJe7KE0EYBpLzsVUgB62HP+JvINyEKECjbx+jgVsi5fnJ+iVvdFohFteyF+sJfrpc3A+1VuWKfNgWjFvbyglw7cJmDmsDMN43a39vD0bvNt3pTbLOYRK9tMheV8ov4VJk+yXXgCBG6Yw4z3tRvZAg3c= ubuntu@ip-172-31-14-145"

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
