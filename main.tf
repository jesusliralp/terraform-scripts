terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_security_group" "default" {
  name_prefix = "default"
}

resource "aws_security_group_rule" "mysql_ingress" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.default.id
}

resource "aws_db_instance" "example-mysql-rds-instance" {
  allocated_storage         = 10
  max_allocated_storage     = 50
  db_name                   = "mydb"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  username                  = var.username
  password                  = var.password
  parameter_group_name      = "default.mysql5.7"
  vpc_security_group_ids    = [ aws_security_group.default.id ]
  skip_final_snapshot       = true
  publicly_accessible       = true
}