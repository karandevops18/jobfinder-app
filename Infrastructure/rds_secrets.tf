# DB security group
resource "aws_security_group" "db_sg" {
  name   = "${var.project}-${var.env}-db-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.svc_sg.id]
    description     = "Allow ECS tasks to connect to RDS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Project = var.project, Env = var.env }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.env}-db-subnetgrp"
  subnet_ids = module.vpc.private_subnets
  tags       = { Project = var.project, Env = var.env }
}

resource "aws_db_instance" "postgres" {
  identifier              = "${var.project}-${var.env}-db"
  engine                  = "postgres"
  engine_version          = "15.10"
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  db_name                    = "jobfinderdb"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  deletion_protection     = false
  tags = { Project = var.project, Env = var.env }
}

# Compose DATABASE_URL and store in Secrets Manager
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  numeric  = true
  special = false
}

resource "aws_secretsmanager_secret" "dburl" {
  name = "${var.project}-${var.env}-dburl-${random_string.suffix.result}"
  description = "RDS connection string for ${var.project}"
  tags = { Project = var.project, Env = var.env }
}

resource "aws_secretsmanager_secret_version" "dburl_ver" {
  secret_id     = aws_secretsmanager_secret.dburl.id
  secret_string = jsonencode({
    DATABASE_URL = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.postgres.address}:5432/jobfinderdb"
  })
}
