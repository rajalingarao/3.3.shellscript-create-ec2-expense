resource "aws_instance" "expense_frontend" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.frontend_instance.instance_type
    vpc_security_group_ids = [var.allow_all]
    root_block_device {
        encrypted             = false
        volume_type           = "gp3"
        volume_size           = 50
        iops                  = 3000
        throughput            = 125
        delete_on_termination = true
    }
    tags = {
        Name = "frontend"
    }
}
resource "aws_route53_record" "frontend_r53" {
    zone_id = var.zone_id
    name    = "frontend.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.expense_frontend.public_ip]
    allow_overwrite = true
}

resource "aws_instance" "expense_backend" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.backend_instance.instance_type
    vpc_security_group_ids = [var.allow_all]
    root_block_device {
        encrypted             = false
        volume_type           = "gp3"
        volume_size           = 50
        iops                  = 3000
        throughput            = 125
        delete_on_termination = true
    }
    tags = {
        Name = "backend"
    }
}
resource "aws_route53_record" "backend_r53" {
    zone_id = var.zone_id
    name    = "backend.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.expense_backend.public_ip]
    allow_overwrite = true
}

resource "aws_instance" "expense_mysql" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.mysql_instance.instance_type
    vpc_security_group_ids = [var.allow_all]
    root_block_device {
        encrypted             = false
        volume_type           = "gp3"
        volume_size           = 50
        iops                  = 3000
        throughput            = 125
        delete_on_termination = true
    }
    tags = {
        Name = "mysql"
    }
}
resource "aws_route53_record" "mysql_r53" {
    zone_id = var.zone_id
    name    = "mysql.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.expense_mysql.public_ip]
    allow_overwrite = true
}