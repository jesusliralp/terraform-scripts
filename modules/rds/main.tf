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
  vpc_security_group_ids    = var.vpc_security_group_ids
  skip_final_snapshot       = true
  publicly_accessible       = true
}