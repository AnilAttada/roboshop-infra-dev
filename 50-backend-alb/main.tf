module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"

  internal = true
  name    = "${var.project}-${var.environment}-backend-alb" #roboshop-dev-backkend-alb
  vpc_id  = local.vpc_id
  subnets = local.private_subnet_ids
  create_security_group = false
  security_groups = [local.backend_alb_sg_id]
  enable_deletion_protection = false

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}

resource "aws_lb_listener" "backend_alb" {
  load_balancer_arn = module.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, This is coming from Backend ALB created by using  module</h1>"
      status_code  = "200"
    }
  }
}