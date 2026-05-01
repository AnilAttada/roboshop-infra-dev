module "frontend" {
    source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id = local.vpc_id
}

module "bastion" {
    source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.bastion_sg_name
    sg_description = var.bastion_sg_description
    vpc_id = local.vpc_id
}

module "backend_alb" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.backend_alb_sg_name
  sg_description = var.backend_alb_sg_description
  vpc_id = local.vpc_id
}

module "vpn" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.vpn_sg_name
  sg_description = var.vpn_sg_description
  vpc_id = local.vpc_id
}

module "mongodb" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.mongodb_sg_name
  sg_description = var.mongodb_sg_description
  vpc_id = local.vpc_id
}

module "redis" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.redis_sg_name
  sg_description = var.redis_sg_description
  vpc_id = local.vpc_id
}

module "mysql" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.mysql_sg_name
  sg_description = var.mysql_sg_description
  vpc_id = local.vpc_id
}

module "rabbitmq" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.rabbitmq_sg_name
  sg_description = var.rabbitmq_sg_description
  vpc_id = local.vpc_id
}

module "catalogue" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.catalogue_sg_name
  sg_description = var.catalogue_sg_description
  vpc_id = local.vpc_id
}

#bastion accepting ports from my laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

#backend_alb accepting connections from bastion on port no 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}

#VPN Ports needed are 22, 443, 1194, 943 allowed from public
resource "aws_security_group_rule" "vpn_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type = "ingress"
  from_port = 1194
  to_port = 1194
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type = "ingress"
  from_port = 943
  to_port = 943
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

#backend_alb accepting connection from vpn
resource "aws_security_group_rule" "backend_alb_vpn" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}

#Mongodb allowing connections from VPN on ports: 22,27017
resource "aws_security_group_rule" "mongobd_vpn" {
  count = length(var.mongodb_vpn_ports)
  type = "ingress"
  from_port = var.mongodb_vpn_ports[count.index]
  to_port = var.mongodb_vpn_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mongodb.sg_id
}

#REDIS allowing connections from VPN on ports: 22,6379
resource "aws_security_group_rule" "redis_vpn" {
  count = length(var.redis_vpn_ports)
  type = "ingress"
  from_port = var.redis_vpn_ports[count.index]
  to_port = var.redis_vpn_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.redis.sg_id
}

#mysql allowing connections from VPN on ports: 22,3306
resource "aws_security_group_rule" "mysql_vpn" {
  count = length(var.mysql_vpn_ports)
  type = "ingress"
  from_port = var.mysql_vpn_ports[count.index]
  to_port = var.mysql_vpn_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mysql.sg_id
}

#rabbitmq allowing connections from VPN on ports: 22,5672
resource "aws_security_group_rule" "rabbitmq_vpn" {
  count = length(var.rabbitmq_vpn_ports)
  type = "ingress"
  from_port = var.rabbitmq_vpn_ports[count.index]
  to_port = var.rabbitmq_vpn_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.rabbitmq.sg_id
}

# catalogue accepting connections from backend_alb , vpn & bastion on ports : 22 , 8080 , and requesting mongodb on 27017
resource "aws_security_group_rule" "catalogue_backend_alb" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.catalogue.sg_id
}

#catalogue from vpn on 22 and 8080
resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

#catalogue accepting from bastion 22
resource "aws_security_group_rule" "catalogue_bastion_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.catalogue.sg_id
}

#mongodb accepting from catalogue on 27017
resource "aws_security_group_rule" "mongodb_catalogue" {
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id = module.mongodb.sg_id
}