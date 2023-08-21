module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name                 = var.VPC_NAME
  cidr                 = var.VPC_CIDR
  azs                  = [var.ZONE1, var.ZONE2, var.ZONE3]
  private_subnets      = [var.PRIV_SUB_1, var.PRIV_SUB_2, var.PRIV_SUB_1]
  public_subnets       = [var.PUB_SUB_1, var.PUB_SUB_2, var.PUB_SUB_3]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  vpc_tags = {
    Name = var.VPC_NAME
  }

  tags = {
    Name        = "terraVPC"
    Environment = "Production"
  }
}