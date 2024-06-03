# create a service on the cloud - launch an ec2 instance on aws
# HCL syntax key = value
provider "aws" {

    # which region eu-west-1
    region = var.region
}

resource "aws_vpc" "tech258_muyis_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "tech258_muyis_pub_subnet" {
  vpc_id     = aws_vpc.tech258_muyis_vpc.id
  cidr_block = var.pub_subnet_cidr
  availability_zone = var.availability

  tags = {
    Name = "tech258_muyis_pub_subnet"
  }
}

resource "aws_subnet" "tech258_muyis_priv_subnet" {
  vpc_id     = aws_vpc.tech258_muyis_vpc.id
  cidr_block = var.priv_subnet_cidr
  availability_zone = var.availability

  tags = {
    Name = "tech258_muyis_priv_subnet"
  }
}

resource "aws_security_group" "tech258_muyis_allow_22_80_3000" {
  name        = var.sg_app_name
  description = "Allow inbound 22 80 3000"
  vpc_id      = aws_vpc.tech258_muyis_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.access_port]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.access_port]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.access_port]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.access_port]
  }
  tags = {
    Name = var.sg_app_name
  }
}
# which service/resource - ec2
resource "aws_instance" "app_instance" {

    # pick the ami
    ami = var.app_ami_id
    # "ami-02f0341ac93c96375"

    # size of instance/ type of instance - t2micro
    instance_type = var.instance_type
    
    subnet_id = aws_subnet.tech258_muyis_pub_subnet.id

    vpc_security_group_ids = [aws_security_group.tech258_muyis_allow_22_80_3000.id]

    # associate pub ip
    associate_public_ip_address = true
    
    # ssh key pair
    key_name = var.ssh
    
    # name instance
    tags = {
        Name = var.name_instance
    }
}
provider "github" {
 
  token = var.GITHUB_TOKEN
 
}
 
 
resource "github_repository" "automated_repo" {
  name        = var.repo_name
  description = "terraform repo"
  visibility  = "public"  # Change to "private" if needed
}
# store in s3 bucket
# terraform {
#   backend "s3" {
#     bucket = "tech258-muyis-terraform-bucket"
#     key = "dev/terraform.tfstate"
#     region = "eu-west-1"
#   }
# }