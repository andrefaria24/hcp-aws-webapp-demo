terraform {
    cloud {
        organization = "acfaria-hashicorp"

        workspaces {
            name = "networking"
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

module "aws_vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.12.0"
    name = var.aws_vpc_name
    cidr = var.aws_vpc_cidr
    azs = var.aws_azs
    public_subnets = var.aws_pub_subnets
    private_subnets = var.aws_pvt_subnets
    enable_nat_gateway = true
    enable_vpn_gateway = false
}

resource "aws_security_group" "allow_http"{
    name = "allow_http"
    description = "Allow HTTP inbound traffic"
    vpc_id = module.aws_vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
    security_group_id = aws_security_group.allow_http.id
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = 80
    ip_protocol       = "tcp"
    to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
    security_group_id = aws_security_group.allow_http.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1"
}