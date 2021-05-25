resource "aws_timestreamwrite_database" "timestream_db" {
  database_name = var.database_name
  tags          = var.tags
}

resource "aws_timestreamwrite_table" "silos_data_table" {
  database_name = aws_timestreamwrite_database.timestream_db.database_name

  table_name = var.table_name

  retention_properties {
    magnetic_store_retention_period_in_days = var.retention_properties.magnetic_store_retention_period_in_days
    memory_store_retention_period_in_hours  = var.retention_properties.memory_store_retention_period_in_hours
  }

  tags = var.tags
}
