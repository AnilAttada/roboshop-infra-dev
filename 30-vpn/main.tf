resource "aws_instance" "vpn" {
    ami = "ami-07cf32f9bd55a9457"
    instance_type = var.instance_type
    vpc_security_group_ids = [local.vpn_sg_id]
    subnet_id = local.public_subnet_id
    key_name = "anil"
    user_data = file("openvpn.sh")

    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-vpn"
        }
    )
}