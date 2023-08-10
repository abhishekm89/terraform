resource "aws_key_pair" "terra_key" {
  key_name = "terraLOCK"
  public_key = file(var.PUB_KEY_PATH)
}