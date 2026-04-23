module "vpc" {
  source = "git::https://github.com/AnilAttada/terraform-aws-vpc.git?ref=main"
  project = var.project
  environment = var.environment
  cidr_block = var.cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  database_subnet_cidr_block = var.database_subnet_cidr_block

  vpc_tags = {
    Name = "${var.project}-${var.environment}-vpc"
  }
}