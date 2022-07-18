resource "aws_key_pair" "deployer" {
  key_name   = uuid()
  // public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChR9Yvzdut0WTAUcQrOm3+6k+nD5cWOdIaLJzK80ZiD+E5TT43AMt2c3LFCAKovUWm6+1aRTLyC8bjG/RZ2L0n+UYtjUEhJaDnPvEC4hVFQD3lEv7lDh6Yl81/JJcLGSkZXeKvbEwoYY1L3uxOWS4c7U4shl86xQZxAy5ctY1RoA2oKz0o6VwIl6Xc5esXIW2OwwBncFXSVj2MyGded8FAFemVEY+2f4Lhd9qa0Zht2JpKPRmmCvj/LspO0IQrmhtl7pzLW6wfsmYf5fUBRiYtgWW8JLV+GelcOZwEt1jB7Urw650pKTGChFdThLA2l0sREshwsHL5n+zFvgG8VCMbwRJG9WqMKRRnVySMTVoVqJA2/tHAncYFnBzILv6mxQ7H8xcXRC1TVU5F94g+2JhtS8RHfmqH2IUB0jMYlAQuDb4oQm13nOaQ+g19BSQoBvPe03NGe3i+w288KXEN07X8VSWanZ4yGaI8Aw7Hdn//uHUSyoI7hQFTqtFC4VljU5k= admin@mediacaris2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCsAG1B1TkH8S8J0t+k9yA4d44+fTCvVZ7v0Z+xZwTUjOuzpDDv6Xb2LmoPU10tAtN/RBECpl8AueV6aFVh84UnExvMGDjwSejlnWRoxdfIsUQZggiav2wLI9r2eaAM70YQuq/0AWkrgghT5fAGVYtGFWGXIps7NCMG98O2L+E5amA8x0Q4Vo9Dn4TXDfhNY65JOcVx97IV4awNt3CZjhjI6W++Cg2ZDhApC3Jvv0bWOc5/+E0ytKY0Ss9TiY73KCA4fpTKGi00Qz88fnwpEJEX36LPa2crcjY6C7GDnilj7DtJwfIxrge40pMtcn89kjswN1NBZGmTyFU28GLMfT8oYkJ+L5GgvCvUE0R7ir2hyKWZzAUYLQdUnjDaF8sZMdaVZcct2Cupt2KwFEljUiwkrfVjI2TUYuuiefH0n3W0nvUdht45WWxp1GHYo0hCriTG7fyFqUz3QehwISTMVtkxRKwQzxfLfjiF7ZQZKwCbGrAwzDyDiEQMbgE4hExxjjmXfGlezeWoZ5mc3ziitR+QwupF3fAZPUsoNjSeBGKAhJpGCbed1Ey3bMbQu8cOC16Hloy8U63zNoCRICCN0JGFIxswlVmWC1VGPl71qwyyafoTdjQSnigva1z5ENwnKp35UYbTSLfhNu3Myj7EvhofUOzCDRySFgiEzsovS66edw== youssra@mednourconsulting.com"

  tags = {
    Name = "${var.environment_name}-${var.server_name}-key"
  }
}


resource "aws_instance" "kibana" {
  ami               = "ami-0fa49cc9dc8d62c84"
  instance_type     = "t2.micro"
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
    Name = "${var.environment_name}-${var.server_name}-server"
  }


}

