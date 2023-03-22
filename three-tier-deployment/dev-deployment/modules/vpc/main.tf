data "aws_security_group" "default" { }

locals {
  bastion_security_group_id = data.aws_security_group.default.id
  rds_security_group_id = data.aws_security_group.default.id
}

resource "aws_security_group_rule" "bastion_ssh" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = local.bastion_security_group_id
}

resource "aws_security_group_rule" "rds_mysql" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  security_group_id = local.rds_security_group_id
  source_security_group_id = local.bastion_security_group_id
}