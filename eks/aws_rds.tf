resource "aws_security_group" "rds-sg" {
  name   = "sg1-rds-bitbucket-${var.region}"
  vpc_id = var.vpc_id
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group-${var.cluster_name}"
  subnet_ids = var.private_subnet_ids
}


resource "aws_db_instance" "default" {
  allocated_storage   = 10
  engine              = "postgres"
  engine_version      = "14"
  instance_class      = var.db_instance_type
  username            = var.db_username
  password            = var.db_password
  db_name             = "bitbucket"
  skip_final_snapshot = true
  #storage_type = "gp3"
  final_snapshot_identifier = "bitbucket-db"
  db_subnet_group_name      = aws_db_subnet_group.default.id
  vpc_security_group_ids    = [aws_security_group.rds-sg.id]
}

