output "ubuntu_public_ip" {
  value = aws_instance.ubuntu_server.public_ip
}

output "centos_private_ip" {
  value = aws_instance.centos_server.private_ip
}

