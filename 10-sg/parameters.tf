resource "aws_ssm_parameter" "sg_id" {
    name = "/${var.project}/${var.environment}/sg_id"
    type = "String"
    value = module.frontend.sg_id
}