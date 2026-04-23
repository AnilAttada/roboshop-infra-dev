variable "project" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}
variable "cidr_block" {
  default = "132.0.0.0/16"
}
variable "public_subnet_cidr_block" {
  default = ["132.0.1.0/24" , "132.0.2.0/24"]
}
variable "private_subnet_cidr_block" {
  default = ["132.0.11.0/24" , "132.0.12.0/24"]
}
variable "database_subnet_cidr_block" {
  default = ["132.0.21.0/24" , "132.0.22.0/24"]
}