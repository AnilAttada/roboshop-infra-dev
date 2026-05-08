resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_id
  iam_instance_profile = "TerraformAdmin"

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-bastion"
    }
  )

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "sudo yum install -y yum-utils",
            "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo",
            "sudo yum -y install terraform"
        ]
    }
}