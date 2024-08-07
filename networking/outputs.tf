output "aws_sg_http_id" {
  value = aws_security_group.allow_http.id
}

output "aws_pub_sn_id" {
  value = module.aws_vpc.public_subnets[0]
}

output "aws_vpc_id" {
  value = module.aws_vpc.vpc_id
}