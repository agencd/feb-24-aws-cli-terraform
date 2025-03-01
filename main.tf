terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.87.0"
    }
  }
}

provider "aws" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals { # local expressions
  image_id = data.aws_ami.ubuntu.id
}

variable "prefix" { # Input variables
  default = ""
}

resource "aws_instance" "web" {
  ami           = local.image_id
  instance_type = "t2.micro"

  tags = {
    Name = var.prefix
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = var.prefix
  }
}

output "ubuntu_image_id" {
  value = local.image_id
}





# Terraform Configuration Blocks
# 1. terraform block
# 2. provider block
# 3. resource block >>> Create / Modify / Delete
# 4. data block >>> Read from a source
# 5. variable block / input
# 6. local block
# 7. module block > not now
# 8. output block






## Object Oriented Language
# pizza:
#   12":
#     white_sauce:
#       pepperoni:
#     red_sauce:
#       mushroom:
#       pepperoni:

# yaml
# json

