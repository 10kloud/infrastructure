terraform {
  required_version = "~> 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }

  backend "remote" {
    organization = "10kloud"

    workspaces {
      name = "siouxsilos"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

module "network" {
  source = "./modules/network"

  vpc_public_subnets  = var.vpc_public_subnets
  vpc_private_subnets = var.vpc_private_subnets
  vpc_intra_subnets   = var.vpc_intra_subnets

  vpc_azs = var.availability_zones
  tags    = var.tags
}

module "security_rules" {
  source = "./modules/security"

  vpc_public_subnets  = var.vpc_public_subnets
  vpc_private_subnets = var.vpc_private_subnets
  vpc_intra_subnets   = var.vpc_intra_subnets

  vpc_id = module.network.vpc_id
  tags   = var.tags
}

module "database" {
  source = "./modules/database/"

  subnet_ids = module.network.vpc_intra_subnets

  db_username = var.PSQL_USERNAME
  db_password = var.PSQL_PASSWORD

  timestream_db_name    = var.timestream_db_name
  timestream_table_name = var.timestream_table_name

  security_groups = [
    module.security_rules.psql_security_group_id
  ]

  tags = var.tags
}
