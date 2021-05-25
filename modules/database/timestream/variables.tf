variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "table_name" {
  description = "Name of the table to create"
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
    memory_store_retention_period_in_hours  = 6
  }
}

variable "tags" {
  description = "Tags to apply to the timestream database"
  type        = map(string)

  default = {
    Terraform = "true"
  }
}
