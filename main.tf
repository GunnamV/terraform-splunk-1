# terraform fmt --diff (if you want to clean up the code)

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

# ---------IAM------------
# not needed for this  deployment

#----------VPC-----------

resource "aws_vpc" "splunk_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support  = true

  tags {
    Name = "splunk_vpc"
  }
}


#-------------Internet GW----------

resource "aws_internet_gateway" "splunk_internet_gateway" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  
  tags {
    Name = "splunk_igw"
   }
}


#---------------Route tables---------

resource "aws_route_table" "splunk_public_rt" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.splunk_internet_gateway.id}"
    }

  tags {
    Name = "splunk_public"
  }

}

resource "aws_default_route_table" "splunk_private_rt" {
  default_route_table_id = "${aws_vpc.splunk_vpc.default_route_table_id}"

  tags {
   Name = "splunk_private"
  }
}


#---------------Subnets----------------------

resource "aws_subnet" "splunk_public1_subnet" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  cidr_block = "${var.cidrs["public1"]}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "splunk_public1"
  }

}

resource "aws_subnet" "splunk_public2_subnet" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  cidr_block = "${var.cidrs["public2"]}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "splunk_public2"
  }

}

resource "aws_subnet" "splunk_private1_subnet" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  cidr_block = "${var.cidrs["private1"]}"
  map_public_ip_on_launch = false
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "splunk_private1"
  }

}


resource "aws_subnet" "splunk_private2_subnet" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  cidr_block = "${var.cidrs["private2"]}"
  map_public_ip_on_launch = false
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "splunk_private2"
  }

}

# Subnet Associations 
# public

resource "aws_route_table_association" "splunk_public1_assoc" {
  subnet_id = "${aws_subnet.splunk_public1_subnet.id}"
  route_table_id = "${aws_route_table.splunk_public_rt.id}"

}

resource "aws_route_table_association" "splunk_public2_assoc" {
  subnet_id = "${aws_subnet.splunk_public2_subnet.id}"
  route_table_id = "${aws_route_table.splunk_public_rt.id}"

}


#private

resource "aws_route_table_association" "splunk_private1_assoc" {
  subnet_id = "${aws_subnet.splunk_private1_subnet.id}"
  route_table_id = "${aws_default_route_table.splunk_private_rt.id}"

}

resource "aws_route_table_association" "splunk_private2_assoc" {
  subnet_id = "${aws_subnet.splunk_private2_subnet.id}"
  route_table_id = "${aws_default_route_table.splunk_private_rt.id}"

}

#Security groups

resource "aws_security_group" "splunk_public_sg" {
  name = "splunk_public_sg"
  description = "Used for access to the prod instance"
  vpc_id = "${aws_vpc.splunk_vpc.id}"

# rules

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port = 9997
    to_port   = 9997
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8000
    to_port   = 8000
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }

}

resource "aws_security_group" "splunk_private_sg" {
  name = "splunk_private_sg"
  description = "Used for private instances"
  vpc_id = "${aws_vpc.splunk_vpc.id}"

#rules

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#Key_Pair

resource "aws_key_pair" "splunk_auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

# instance

resource "aws_instance" "splunk_prod" {
  instance_type = "${var.prod_instance_type}"
  ami = "${var.prod_ami}"
  tags {
    Name = "splunk_prod"
  }

  key_name = "${aws_key_pair.splunk_auth.id}" 
  vpc_security_group_ids = ["${aws_security_group.splunk_public_sg.id}"]
  user_data = "${file("user_data")}"
  subnet_id = "${aws_subnet.splunk_public1_subnet.id}"
 
  provisioner "local-exec"  {
      command = <<EOD
  cat > aws_hosts << EOF
  [splunk]
  ${aws_instance.splunk_prod.public_ip}
  #EOF
  EOD
  }

# ansible playbook
# run the ansible playbook to deploy splunk
  provisioner "local-exec" {
      command = "sleep 6m && ansible-playbook -vv -i aws_hosts splunk..yml"
   }
}


