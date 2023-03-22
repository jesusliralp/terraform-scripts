resource "aws_db_instance" "mysql_rds_instance" {
  identifier = "mysql-rds-instance"
  engine = "mysql"
  engine_version = "5.7.22"
  instance_class = "db.t2.micro"
  allocated_storage = 20
  storage_type = "gp2"
  multi_az = true
  username = var.username
  password = var.password
  publicly_accessible = false
  skip_final_snapshot = true
  vpc_security_group_ids = [var.rds_security_group_id]
}