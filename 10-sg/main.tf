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

module "user" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.user_sg_name
  sg_description = var.user_sg_description
  vpc_id = local.vpc_id
}

module "cart" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.cart_sg_name
  sg_description = var.cart_sg_description
  vpc_id = local.vpc_id
}

module "shipping" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.shipping_sg_name
  sg_description = var.shipping_sg_description
  vpc_id = local.vpc_id
}

module "payment" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.payment_sg_name
  sg_description = var.payment_sg_description
  vpc_id = local.vpc_id
}

module "frontend_alb" {
  source = "git::https://github.com/AnilAttada/terraform-aws-securitygroup.git?ref=main"
  project = var.project
  environment = var.environment
  sg_name = var.frontend_alb_sg_name
  sg_description = var.frontend_alb_sg_description
  vpc_id = local.vpc_id
}

#BASTION
#bastion accepting ports from my laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

#BACKEND_ALB
#backend_alb accepting connections from bastion on port no 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}

#backend_alb accepting connection from vpn on 80
resource "aws_security_group_rule" "backend_alb_vpn" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_bastion" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_frontend" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_cart" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_shipping" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_payment" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.backend_alb.sg_id
}

#VPN
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

#MONGODB
#Mongodb allowing connections from VPN on ports: 22,27017
resource "aws_security_group_rule" "mongobd_vpn" {
  count = length(var.mongodb_ports)
  type = "ingress"
  from_port = var.mongodb_ports[count.index]
  to_port = var.mongodb_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongobd_bastion" {
  count = length(var.mongodb_ports)
  type = "ingress"
  from_port = var.mongodb_ports[count.index]
  to_port = var.mongodb_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mongodb.sg_id
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

resource "aws_security_group_rule" "mongodb_user" {
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.mongodb.sg_id
}

#REDIS
#REDIS allowing connections from VPN on ports: 22,6379
resource "aws_security_group_rule" "redis_vpn" {
  count = length(var.redis_ports)
  type = "ingress"
  from_port = var.redis_ports[count.index]
  to_port = var.redis_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_bastion" {
  count = length(var.redis_ports)
  type = "ingress"
  from_port = var.redis_ports[count.index]
  to_port = var.redis_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.redis.sg_id
}

#MYSQL
#mysql allowing connections from VPN on ports: 22,3306
resource "aws_security_group_rule" "mysql_vpn" {
  count = length(var.mysql_ports)
  type = "ingress"
  from_port = var.mysql_ports[count.index]
  to_port = var.mysql_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {
  count = length(var.mysql_ports)
  type = "ingress"
  from_port = var.mysql_ports[count.index]
  to_port = var.mysql_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.mysql.sg_id
}

#RABBITMQ
#rabbitmq allowing connections from VPN on ports: 22,5672
resource "aws_security_group_rule" "rabbitmq_vpn" {
  count = length(var.rabbitmq_ports)
  type = "ingress"
  from_port = var.rabbitmq_ports[count.index]
  to_port = var.rabbitmq_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_bastion" {
  count = length(var.rabbitmq_ports)
  type = "ingress"
  from_port = var.rabbitmq_ports[count.index]
  to_port = var.rabbitmq_ports[count.index]
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id = module.rabbitmq.sg_id
}

#CATALOGUE
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

#USER
#User accepting connections from vpn on 22 and 8080 
resource "aws_security_group_rule" "user_vpn_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "user_vpn" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "user_bastion_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.user.sg_id
}

#user accepting connections from backend_alb on 8080
resource "aws_security_group_rule" "user_backend_alb" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.user.sg_id
}

#CART
#cart accepting connections from vpn on 22 and 8080
resource "aws_security_group_rule" "cart_vpn_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_vpn" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_bastion_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.cart.sg_id
}

#cart accepting connections from backend_alb on 8080
resource "aws_security_group_rule" "cart_backend_alb" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.cart.sg_id
}

#SHIPPING
#shipping accepting connections from vpn on 22 and 8080
resource "aws_security_group_rule" "shipping_vpn_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_vpn" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_bastion_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.shipping.sg_id
}

#shipping accepting connections from backend_alb on 8080
resource "aws_security_group_rule" "shipping_backend_alb" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.shipping.sg_id
}

#PAYMENT
#payment accepting connections from vpn on 22 and 8080
resource "aws_security_group_rule" "payment_vpn_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_vpn" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_bastion_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.payment.sg_id
}

#payment accepting connections from backend_alb on 8080
resource "aws_security_group_rule" "payment_backend_alb" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.payment.sg_id
}

#FRONTEND_ALB
#frontend_alb allowing connections from http, https on 80 and 443
resource "aws_security_group_rule" "frontend_alb_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}

resource "aws_security_group_rule" "frontend_alb_https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}

#FRONTEND
#frontend allowing connections from frontend_alb on 80
resource "aws_security_group_rule" "frontend_frontend_alb" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.frontend_alb.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.frontend.sg_id
}