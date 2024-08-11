# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

  tags = {
    Name = "main-subnet-group"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# Retrieve Database Password from AWS Parameter Store
# data "aws_ssm_parameter" "rds_password" {
#   name = "rds_password"
# }

# RDS Instance
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "master"
  password             = aws_ssm_parameter.rds_password.value
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot  = true
  storage_encrypted    = true
  kms_key_id           = aws_kms_key.rds.arn

  tags = {
    Name = "my-rds-instance"
  }
}