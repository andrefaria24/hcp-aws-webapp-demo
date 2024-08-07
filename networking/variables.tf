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

variable "aws_vpc_name" {
    description = "VPC Name"
    type = string
    default = ""
}

variable "aws_vpc_cidr" {
    description = "VPC CIDR block"
    type = string
    default = ""
}

variable "aws_azs" {
    description = "Availability zones to be used"
    type = list(string)
    default = [""]
}

variable "aws_pvt_subnets" {
    description = "Private subnets CIDR blocks"
    type = list(string)
    default = [""]
}

variable "aws_pub_subnets" {
    description = "Public subnets CIDR blocks"
    type = list(string)
    default = [""]
}