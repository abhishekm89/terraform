resource "aws_instance" "terraBASTION" {
  ami                    = lookup(var.AMIS, var.REGION)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.terra_key.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = 1
  vpc_security_group_ids = [aws_security_group.terraSG-bastionHost-ec2.id]

  tags = {
    Name        = "terraBASTION"
    Environment = "Production"
  }

  provisioner "file" {
    content     = templatefile("templates/db_deploy.tmpl", { rds-endpoint = aws_db_instance.terraRDS-instance.address, dbuser = var.DB_USER, dbpass = var.DB_PASS })
    destination = "/tmp/db_deploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/db_deploy.sh",
      "sudo /tmp/db_deploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PVT_KEY_PATH)
    host        = self.public_ip # returns PublicIP of BastionHost
  }
  depends_on = [aws_db_instance.terraRDS-instance]
}