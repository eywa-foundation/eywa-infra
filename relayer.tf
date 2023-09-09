resource "aws_instance" "eywa_relayer" {
  count         = 3
  ami           = "ami-0225bc2990c54ce9a" # ubuntu 20.04 (64bit, x86)
  instance_type = "t3.micro"
  key_name      = aws_key_pair.eywa_key.key_name

  # root_block_device {
  #   volume_size = 20
  #   volume_type = "gp2"
  #   encrypted   = false
  # }

  # associate_public_ip_address = false

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.eywa_relayer_network_interface[count.index].id
  }

  tags = { Name = "eywa-relayer" }
}
resource "aws_network_interface" "eywa_relayer_network_interface" {
  count           = 3
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.eywa_relayer_security_group.id]
  tags            = { Name = "eywa-relayer-network-interface" }
}
resource "aws_eip" "eywa_relayer_static_ip" {
  count             = 3
  instance          = aws_instance.eywa_relayer[count.index].id
  network_interface = aws_network_interface.eywa_relayer_network_interface[count.index].id
  vpc               = true
}

output "eywa_relayer_static_ip" {
  value = aws_eip.eywa_relayer_static_ip[*].public_ip
}

