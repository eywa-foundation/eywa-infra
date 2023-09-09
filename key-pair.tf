resource "aws_key_pair" "eywa_key" {
  key_name   = "eywa-key"
  public_key = file(var.key_path.jaehong21_key)
}

