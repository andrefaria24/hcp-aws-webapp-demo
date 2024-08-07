provider "aws" {
    region = var.aws_region
}

data "terraform_remote_state" "networking"{
    backend = "remote"

    config = {
        organization = "acfaria-hashicorp"
        workspaces = {
            name = "networking"
        }
    }
}

resource "aws_instance" "ec2_instance" {
    ami           = var.webserver_ami
    instance_type = var.webserver_instance_type
    key_name      = var.key_name
    subnet_id     = data.terraform_remote_state.networking.outputs.aws_pub_sn_id
    vpc_security_group_ids = [data.terraform_remote_state.networking.outputs.aws_sg_http_id]
    user_data = file("./bootstrap.sh")
}

resource "aws_eip" "web_server_eip" {
    depends_on = [aws_instance.web_server]
}

resource "aws_eip_association" "web_server_eip_assoc" {
    allocation_id = aws_eip.web_server_eip.allocation_id
    instance_id = aws_instance.web_server.id
}