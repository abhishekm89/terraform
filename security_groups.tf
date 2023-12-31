resource "aws_security_group" "terraSG-beanstalk-elb" {
  name        = "terraSG-beanstalk-elb"
  description = "Security group for Beanstalk ELB"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1" // -1 = all protocols
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "terraSG-beanstalk-elb"
    Environment = "Production"
  }
}

resource "aws_security_group" "terraSG-bastionHost-ec2" {
  name        = "terraSG-bastionHost"
  description = "Security group for Bastion Host EC2"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1" // -1 = all protocols
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.MY_IP]
  }
  tags = {
    Name        = "terraSG-bastionHost"
    Environment = "Production"
  }
}

resource "aws_security_group" "terraSG-beanstalk-ec2" {
  name        = "terraSG-beanstalk-ec2"
  description = "Security group for Beanstalk EC2"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1" // -1 = all protocols
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.terraSG-bastionHost-ec2.id]
    // Allowed SSH connection only from BastionHost EC2 instance
  }
  tags = {
    Name        = "terraSG-beanstalk-ec2"
    Environment = "Production"
  }
}
# Backend Services -> RDS | ActiveMQ | ElastiCache
resource "aws_security_group" "terraSG-backend" {
  name        = "terraSG-backend"
  description = "Security group for Backend Services"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1" // -1 = all protocols
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
    security_groups = [aws_security_group.terraSG-beanstalk-ec2.id]
    # Beanstalk-EC2 Instance is allowed to Access backend Services
  }
  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.terraSG-bastionHost-ec2.id]
    # BastionHost-EC2 is allowed to Access RDS on Port 3306 for DB_Initialization
  }
  tags = {
    Name        = "terraSG-backend"
    Environment = "Production"
  }
}

resource "aws_security_group_rule" "terraSG-backend-allow-itself" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535 // all TCP ports
  protocol                 = "tcp"
  security_group_id        = aws_security_group.terraSG-backend.id
  source_security_group_id = aws_security_group.terraSG-backend.id
}