variable "aws_accounts" {
    description = "AWS accounts allowed for resource provisioning"
    type = list(string)
    default = []
}

variable "aws_region" {
    description = "AWS region resources will reside in"
    type = string
    default = ""
}

variable "key_name" {
    type = string
    default = ""
}

variable "webserver_ami" {
    type = string
    default = ""
}

variable "webserver_instance_type" {
    type = string
    default = ""
}