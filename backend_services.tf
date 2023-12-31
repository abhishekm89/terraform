# SubnetGroup for RDS Backend instance
resource "aws_db_subnet_group" "terraRDS-subnetgrp" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet Group for RDS"
  }
}

# SubnetGroup for ElastiCache Backend instance
resource "aws_elasticache_subnet_group" "terraElastiCache-subnetgrp" {
  name       = "elasticache-subnetGroup"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
}

# RDS Backend Instance
resource "aws_db_instance" "terraRDS-instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7.37"
  instance_class         = "db.t2.micro"
  db_name                = var.DB_NAME
  username               = var.DB_USER
  password               = var.DB_PASS
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = false
  multi_az               = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.terraRDS-subnetgrp.name
  vpc_security_group_ids = [aws_security_group.terraSG-backend.id]
}

# ElastiCache Backend Cluster
resource "aws_elasticache_cluster" "terraElastiCache-cluster" {
  cluster_id           = "elasticache-cluster"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  security_group_ids   = [aws_security_group.terraSG-backend.id]
  subnet_group_name    = aws_elasticache_subnet_group.terraElastiCache-subnetgrp.name
}

# ActiveMQ Cluster
resource "aws_mq_broker" "terraActiveMQ-cluster" {
  broker_name        = "activemq-cluster"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.terraSG-backend.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    password = var.RMQ_PASS
    username = var.RMQ_USER
  }
}