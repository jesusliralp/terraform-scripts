provider "aws" {
  region     = "us-west-2"
}

module "dev-deployment" {
  source   = "./dev-deployment"
  username = var.db_dev_username
  password = var.db_dev_password
}