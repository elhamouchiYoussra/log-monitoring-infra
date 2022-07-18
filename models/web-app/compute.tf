
resource "aws_key_pair" "deployer" {
  key_name   = uuid()
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChR9Yvzdut0WTAUcQrOm3+6k+nD5cWOdIaLJzK80ZiD+E5TT43AMt2c3LFCAKovUWm6+1aRTLyC8bjG/RZ2L0n+UYtjUEhJaDnPvEC4hVFQD3lEv7lDh6Yl81/JJcLGSkZXeKvbEwoYY1L3uxOWS4c7U4shl86xQZxAy5ctY1RoA2oKz0o6VwIl6Xc5esXIW2OwwBncFXSVj2MyGded8FAFemVEY+2f4Lhd9qa0Zht2JpKPRmmCvj/LspO0IQrmhtl7pzLW6wfsmYf5fUBRiYtgWW8JLV+GelcOZwEt1jB7Urw650pKTGChFdThLA2l0sREshwsHL5n+zFvgG8VCMbwRJG9WqMKRRnVySMTVoVqJA2/tHAncYFnBzILv6mxQ7H8xcXRC1TVU5F94g+2JhtS8RHfmqH2IUB0jMYlAQuDb4oQm13nOaQ+g19BSQoBvPe03NGe3i+w288KXEN07X8VSWanZ4yGaI8Aw7Hdn//uHUSyoI7hQFTqtFC4VljU5k= admin@mediacaris2"
  tags = {
    Name = "${var.environment_name}-${var.app_name}-key"
  }
}

resource "aws_instance" "instance_1" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.instances.name]
  user_data       = <<-EOF
                echo "Hello, World 3" > index.html
                python3 -m http.server 8080 &
                 EOF
  tags = {
    Name = "${var.environment_name}-${var.app_name}-in1"
  }
}

resource "aws_instance" "instance_2" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.instances.name]
  user_data       = <<-EOF
                 #!/bin/bash
                 echo "Hello, World 3" > index.html
                 python3 -m http.server 8080 &
                 EOF
  tags = {
    Name = "${var.environment_name}-${var.app_name}-in2"
  }
}
