variable "aws_region" {
  description = "Region in which create instances"
  type        = string
  default     = "eu-west-1"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_public_subnets" {
  description = "VPC public subnets"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "vpc_private_subnets" {
  description = "VPC private subnets"
  type        = list(string)
  default     = ["10.0.100.0/24"]
}

variable "vpc_intra_subnets" {
  description = "VPC intra subnets"
  type        = list(string)
  default     = ["10.0.200.0/24", "10.0.201.0/24"]
}

variable "psql_username" {
  description = "Postgres master username"
  type        = string
}

variable "psql_password" {
  description = "Postgres master password"
  type        = string
}

variable "timestream_db_name" {
  description = "Name of the timestream database"
  type        = string
  default     = "clod2021-g5pw-siouxsilos"
}

variable "timestream_table_name" {
  description = "Name of the timestream table"
  type        = string
  default     = "siouxsilos"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Project   = "SiouxSilos"
  }
}
