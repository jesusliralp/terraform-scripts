provider "aws" {
  region  = "us-west-2"
}

module "vpc" {
  source = "./vpc"
}

module "rds" {
  source = "./rds"
  username = var.username
  password = var.password
  vpc_security_group_ids = module.vpc.vpc_security_group_ids
}