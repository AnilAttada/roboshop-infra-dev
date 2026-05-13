resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_id
  iam_instance_profile = "TerraformAdmin"
  user_data = file("bastion.sh")

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-bastion"
    }
  )
}