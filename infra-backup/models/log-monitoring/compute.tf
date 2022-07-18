resource "aws_key_pair" "log-monatoring" {
  key_name   = uuid()
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCsAG1B1TkH8S8J0t+k9yA4d44+fTCvVZ7v0Z+xZwTUjOuzpDDv6Xb2LmoPU10tAtN/RBECpl8AueV6aFVh84UnExvMGDjwSejlnWRoxdfIsUQZggiav2wLI9r2eaAM70YQuq/0AWkrgghT5fAGVYtGFWGXIps7NCMG98O2L+E5amA8x0Q4Vo9Dn4TXDfhNY65JOcVx97IV4awNt3CZjhjI6W++Cg2ZDhApC3Jvv0bWOc5/+E0ytKY0Ss9TiY73KCA4fpTKGi00Qz88fnwpEJEX36LPa2crcjY6C7GDnilj7DtJwfIxrge40pMtcn89kjswN1NBZGmTyFU28GLMfT8oYkJ+L5GgvCvUE0R7ir2hyKWZzAUYLQdUnjDaF8sZMdaVZcct2Cupt2KwFEljUiwkrfVjI2TUYuuiefH0n3W0nvUdht45WWxp1GHYo0hCriTG7fyFqUz3QehwISTMVtkxRKwQzxfLfjiF7ZQZKwCbGrAwzDyDiEQMbgE4hExxjjmXfGlezeWoZ5mc3ziitR+QwupF3fAZPUsoNjSeBGKAhJpGCbed1Ey3bMbQu8cOC16Hloy8U63zNoCRICCN0JGFIxswlVmWC1VGPl71qwyyafoTdjQSnigva1z5ENwnKp35UYbTSLfhNu3Myj7EvhofUOzCDRySFgiEzsovS66edw== youssra@mednourconsulting.com"

  tags = {
    Name = "${var.environment_name}-${var.server_name}-key"
  }
}


resource "aws_instance" "kibana" {
  ami               = "ami-0fa49cc9dc8d62c84"
  instance_type     = "m4.large"
  availability_zone = "us-east-2a"
  key_name          = aws_key_pair.deployer.key_name

  user_data = <<-EOF
                 #!/bin/bash
                 sudo apt update -y
                 EOF

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  tags = {
    Name = "${var.environment_name}-kibanar"
  }


}

