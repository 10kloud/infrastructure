variable "db_username" {
  description = "Username for the master db user"
  type        = string
}

variable "db_password" {
  description = "Password for the master db user"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the RDS instance"
  type        = map(string)
}

variable "subnet_ids" {
  description = "VPC subnets"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups for the rds instance"
  type        = list(string)
}
