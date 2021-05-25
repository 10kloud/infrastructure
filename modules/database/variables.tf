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

variable "timestream_db_name" {
  description = "Name of the timestream database"
  type        = string
}

variable "timestream_table_name" {
  description = "Name of the table used in timestream"
  type        = string
}

variable "retention_properties" {
  description = "Retention policies"
  type = object({
    magnetic_store_retention_period_in_days = number
    memory_store_retention_period_in_hours  = number
  })

  default = {
    magnetic_store_retention_period_in_days = 2
    memory_store_retention_period_in_hours  = 4
  }
}
