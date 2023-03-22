module "vpc" {
  source = "./modules/vpc"
}

module "rds" {
  source = "./modules/rds"
  username = var.username
  password = var.password
  rds_security_group_id = module.vpc.rds_security_group_id
}

module "ec2" {
  source = "./modules/ec2"
  bastion_security_group_id = module.vpc.bastion_security_group_id
}