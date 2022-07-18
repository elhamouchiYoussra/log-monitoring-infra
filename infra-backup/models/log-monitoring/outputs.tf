output "server_ip_addr" {
  value = aws_instance.server.public_ip
}
output "server_ip_dns" {
  value = aws_instance.server.public_dns
}