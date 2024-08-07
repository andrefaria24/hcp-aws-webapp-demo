output "webserver_public_ip" {
  value = aws_eip.web_server_eip.public_ip
}