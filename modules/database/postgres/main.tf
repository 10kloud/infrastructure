locals {
  major_version = split(".", var.pg_version)[0]
}

module "postgres" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.0.0"

  identifier = var.identifier

  engine         = "postgres"
  engine_version = var.pg_version
  family         = "postgres${local.major_version}"

  instance_class = var.ec2_instance

  allocated_storage = var.allocated_storage
  storage_encrypted = var.storage_encrypted

  name     = var.db_name
  username = var.db_username
  password = var.db_password
  port     = 5432

  subnet_ids             = var.db_subnet_ids
  vpc_security_group_ids = var.db_security_groups
  multi_az               = var.multi_az

  maintenance_window = var.maintenance_window
  backup_window      = var.backup_window

  tags = var.tags
}
