terraform {
    cloud {
        organization = "acfaria-hashicorp"

        workspaces {
            name = "compute"
        }
    }

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.61.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
    allowed_account_ids = var.aws_accounts
}

resource "aws_instance" "web_server" {
    ami           = var.webserver_ami
    instance_type = var.webserver_instance_type
    key_name      = var.key_name
    subnet_id = module.aws_vpc.public_subnets[0]
    vpc_security_group_ids = [aws_security_group.allow_http.id]
    user_data = file("./bootstrap.sh")
}

resource "aws_eip" "web_server_eip" {
    depends_on = [aws_instance.web_server]
}

resource "aws_eip_association" "web_server_eip_assoc" {
    allocation_id = aws_eip.web_server_eip.allocation_id
    instance_id = aws_instance.web_server.id
}