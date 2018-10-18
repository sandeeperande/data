provider "aws" {
  access_key = "XXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXX"
  region = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "172.20.10.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "172.20.20.0/24"
}


resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

}

resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-east-1a"

}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "us-east-1b"

 
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet RT"
  }
}

resource "aws_route_table_association" "web-public-rt" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}


resource "aws_instance" "puppet" {
   ami  = "ami-0ac019f4fcb7cb7e6"
   instance_type = "t2.micro"
   key_name = "test2"
   subnet_id = "${aws_subnet.public-subnet.id}"
   associate_public_ip_address = true
   source_dest_check = true
   user_data = "${file("install.sh")}"

  tags {
    Name = "saltstack"
  }
}

resource "aws_instance" "tomcat" {
   ami  = "ami-0ac019f4fcb7cb7e6"
   instance_type = "t2.micro"
   key_name = "test2"
   subnet_id = "${aws_subnet.private-subnet.id}"
   associate_public_ip_address = true
   source_dest_check = false

  tags {
    Name = "webserver"
  }
}