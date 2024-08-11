# Security Group for Web Server
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id

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

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# EC2 Instances for Web Server
resource "aws_instance" "web" {
  ami                         = "ami-01b799c439fd5516a"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public1.id
  associate_public_ip_address = true
  key_name                    = "potera"
  security_groups             = [aws_security_group.web.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "web-server-1"
  }
}

# EC2 Instances for Web Server in Public Subnet 2
resource "aws_instance" "web2" {
  ami                         = "ami-01b799c439fd5516a"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public2.id
  associate_public_ip_address = true
  key_name                    = "potera"
  security_groups             = [aws_security_group.web.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "web-server-2"
  }
}
