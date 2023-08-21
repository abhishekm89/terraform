variable "REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1  = "ami-0261755bbcb8c4a84"
    us-east-2  = "ami-0430580de6244e02e"
    ap-south-1 = "ami-08e5424edfe926b43"
  }
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "USER" {
  default = "ubuntu"
}

variable "PUB_KEY_PATH" {
  default = "terraLOCK.pub"
}

variable "PVT_KEY_PATH" {
  default = "terraLOCK"
}

variable "MY_IP" {
  default = "103.5.132.4/32"
}

variable "VPC_NAME" {
  default = "terraVPC"
}

variable "VPC_CIDR" {
  default = "172.20.0.0/16"
}

variable "ALL_IPv4" {
  default = "0.0.0.0/0"
}

variable "ALL_IPv6" {
  default = "::/0"
}

variable "PUB_SUB_1" {
  default = "172.20.1.0/24"
}

variable "PUB_SUB_2" {
  default = "172.20.2.0/24"
}

variable "PUB_SUB_3" {
  default = "172.20.3.0/24"
}

variable "PRIV_SUB_1" {
  default = "172.20.4.0/24"
}

variable "PRIV_SUB_2" {
  default = "172.20.5.0/24"
}

variable "PRIV_SUB_3" {
  default = "172.20.6.0/24"
}

variable "RMQ_USER" {
  default = "rabbit"
}

variable "RMQ_PASS" {
  default = "rabbit123"
}

variable "DB_NAME" {
  default = "accounts"
}

variable "DB_USER" {
  default = "admin"
}

variable "DB_PASS" {
  default = "admin123"
}