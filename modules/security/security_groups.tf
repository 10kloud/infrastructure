module "web_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "clod2021-g5pw-web-sg"
  description = "Security group for web-server with HTTP and HTTPS ports"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.web_server_ingress_cidr_blocks
  ingress_rules = [
    "https-443-tcp",
    "http-80-tcp"
  ]

  tags = var.tags
}

module "postgres_db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

  name        = "clod2021-g5pw-psql-sg"
  description = "Security group for Postgres"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.vpc_private_subnets
  ingress_rules = [
    "postgresql-tcp"
  ]

  tags = var.tags
}
