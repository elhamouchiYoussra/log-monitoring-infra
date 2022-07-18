

# 1. creat vpc

resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.environment_name}-${var.server_name}-vpc"
  }
}

# 2. creat internet getway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id
}
# 3. aws route table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.environment_name}-${var.server_name}-rt"
  }
}


# 4.Create a Subnet
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.prod-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "${var.environment_name}-${var.server_name}-sb"
  }

}


# 6. associate a subnet with route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id

}


# 7. security group for kibana instance
resource "aws_security_group" "sg-kibana" {
  name        = "allow_web_traffic"
  description = "allow web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
 tags = {
    Name = "${var.environment_name}-kibana"
  }
}


# 7. creat network interfece for kibana instance 
resource "aws_network_interface" "nic-kibana" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = [var.private_ip]
  security_groups = [aws_security_group.sg-kibana.id]
   tags = {
    Name = "${var.environment_name}-kibana"
  }
}


# 8. creat elastic ip for kibana instance 
resource "aws_eip" "elastic-ip" {
  vpc                       = true
  network_interface         = aws_network_interface.nic-kibana.id
  associate_with_private_ip = var.private_ip
  depends_on                = [aws_internet_gateway.gw]
  tags = {
    Name = "${var.environment_name}-${var.server_name}-ip"
  }
}


# 7. security group for kibana instance
resource "aws_security_group" "sg-kibana" {
  name        = "allow_web_traffic"
  description = "allow web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
 tags = {
    Name = "${var.environment_name}-kibana"
  }
}


# 7. creat network interfece for kibana instance 
resource "aws_network_interface" "nic-kibana" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = [var.private_ip]
  security_groups = [aws_security_group.sg-kibana.id]
   tags = {
    Name = "${var.environment_name}-kibana"
  }
}


# 8. creat elastic ip for kibana instance 
resource "aws_eip" "elastic-ip" {
  vpc                       = true
  network_interface         = aws_network_interface.nic-kibana.id
  associate_with_private_ip = var.private_ip
  depends_on                = [aws_internet_gateway.gw]
  tags = {
    Name = "${var.environment_name}-${var.server_name}-ip"
  }
}
