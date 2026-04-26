variable "frontend_sg_name" {
  default = "frontend"
}
variable "frontend_sg_description" {
  default = "Creating SG for allowing connection to frontend"
}
variable "project" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}
variable "bastion_sg_name" {
  default = "bastion"
}
variable "bastion_sg_description" {
  default = "Creating SG for bastion host"
}
variable "backend_alb_sg_name" {
  default = "backend-alb"
}
variable "backend_alb_sg_description" {
  default = "Creating SG for backend alb"
}
variable "vpn_sg_name" {
  default = "vpn"
}
variable "vpn_sg_description" {
  default = "Creating SG for VPN"
}
variable "mongodb_sg_name" {
  default = "mongodb"
}
variable "mongodb_sg_description" {
  default = "Creating SG for Mongodb"
}
variable "mongodb_vpn_ports" {
  default = [22 , 27017]
}
variable "redis_sg_name" {
  default = "redis"
}
variable "redis_sg_description" {
  default = "Creating SG for redis"
}
variable "redis_vpn_ports" {
  default = [22 , 6379]
}
variable "mysql_sg_name" {
  default = "mysql"
}
variable "mysql_sg_description" {
  default = "Creating SG for mysql"
}
variable "mysql_vpn_ports" {
  default = [22 , 3306]
}
variable "rabbitmq_sg_name" {
  default = "rabbitmq"
}
variable "rabbitmq_sg_description" {
  default = "Creating SG for rabbitmq"
}
variable "rabbitmq_vpn_ports" {
  default = [22 , 5672]
}