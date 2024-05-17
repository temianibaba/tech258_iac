# Terraform
- [Terraform](#terraform)
  - [Installing Terraform](#installing-terraform)
  - [Creating keys as env var in windows](#creating-keys-as-env-var-in-windows)
  - [Which region](#which-region)
  - [Then instructions](#then-instructions)
  - [VPC](#vpc)
  - [Abstraction](#abstraction)
  - [Multiple providers](#multiple-providers)
  - [Blockers and tips](#blockers-and-tips)

## Installing Terraform
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
1. Extract to a folder
2. Go to advanced system settings (sysdm.cpl in run window)
3. Edit Path variable
4. Add new path 

## Creating keys as env var in windows
- click windows key
- type env
- system or env var choose env
- click new
- enter name **(AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY)** then value
- save and repeat for other key
## Which region
eu-west-1
## Then instructions
```bash
1. nano main.tf
provider "aws" {

    # which region eu-west-1
    region = <your_region_goes_here>
}
2. terraform init # inside terraform folder
3. nano main.tf # finish configuring your 
# which service/resource - ec2
resource "aws_instance" "app_instance" {

    # pick the ami
    ami = var.app_ami_id
    # "ami-02f0341ac93c96375"

    # size of instance/ type of instance - t2micro
    instance_type = var.instance_type
    
    subnet_id = var.pub_subnet_id

    vpc_security_group_ids = [var.sg]

    # associate pub ip
    associate_public_ip_address = true
    
    # ssh key pair
    key_name = var.ssh
    
    # name instance
    tags = {
        Name = var.name_instance
    }
}
4. terraform plan # checks your main.pf
5. terraform apply # makes your instance
```
## VPC
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc.html
When creating a Virtual Private Cloud there are a few key things
1. Make VPC with cidr block
2. Make subnets with cidr blocks within the VPC
3. Make secutiry gorups
4. Call subnets and security groups in main.tg

```bash
resource "aws_subnet" "tech258_muyis_pub_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.pub_subnet_cidr
  availability_zone = var.availability

  tags = {
    Name = var.pub_subnet_name
  }
}

resource "aws_subnet" "tech258_muyis_priv_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.priv_subnet_cidr
  availability_zone = var.availability

  tags = {
    Name = var.priv_subnet_name
  }
}

resource "aws_security_group" "tech258_muyis_allow_22_80_3000" {
  name        = var.sg_name
  description = "Allow inbound 22 80 3000"
  vpc_id      = var.vpc_id

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
    Name = var.sg_name
  }
}


```

## Abstraction
To stop repeating ourselves, we create variables as shown below in a variables.tf file
```bash
variable "name_instance" {
    
    default = "tech258_muyis_terraform_app"
}

# you can call a variable in the main.tf file as shown below

# name instance
tags = {
    Name = var.name_instance
}

# calling the ssh sg and subnets when configuring instance

    subnet_id = var.pub_subnet_id

    vpc_security_group_ids = [var.sg_id]

    key_name = var.ssh
```
## Multiple providers
```bash
provider "github" {
 
  token = var.GITHUB_TOKEN
 
}
 
 
resource "github_repository" "automated_repo" {
  name        = var.repo_name
  description = "terraform repo"
  visibility  = "public"  # Change to "private" if needed
}
```
## Blockers and tips
- Access denied
- If access granted then its a syntax
- No valid credential source - admin access
- **HARD CODING KEYS** Don't hardcode access keys and secret access keys
- Not everything needs ""
- Only do variables for names
- Hide variables in .gitignore for security purposes