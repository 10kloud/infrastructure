variable "identifier" {
  description = "Name of the RDS instance"
  type        = string
  default     = "clod2021-g5pw-siouxsilos"
}

variable "pg_version" {
  description = "Postgres version"
  type        = string
  default     = "13.1"
}

variable "ec2_instance" {
  description = "Class of EC2 instance to host postgresql"
  type        = string
  default     = "db.t2.medium"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "storage_encrypted" {
  description = "Whether crypt storage or not"
  type        = bool
  default     = true
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Username of the database user"
  type        = string
}

variable "db_password" {
  description = "Password of the database user"
  type        = string
  sensitive   = true
}

variable "db_subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
}

variable "db_security_groups" {
  description = "A list of security group ids"
  type        = list(string)
}

variable "multi_az" {
  description = "Specifies if the Postgres instance is multi AZ"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "Time range in which is allowed to do maintenance"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  description = "Time range in which is allowed to do backups"
  type        = string
  default     = "04:00-06:00"
}

variable "tags" {
  description = "Tags to add to the resource"
  type        = map(string)
}
