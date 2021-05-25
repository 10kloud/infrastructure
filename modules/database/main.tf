module "postgresql" {
  source = "./postgres"

  identifier = "clod2021-g5pw-siouxsilos"

  ec2_instance = "db.t3.micro"

  db_name     = "siouxsilos"
  db_username = var.db_username
  db_password = var.db_password

  db_subnet_ids      = var.subnet_ids
  db_security_groups = var.security_groups

  tags = var.tags
}
