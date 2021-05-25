output "psql_security_group_id" {
  description = "ID of the security group used for postgres DBs"
  value       = module.postgres_db_sg.security_group_id
}

output "web_security_group_id" {
  description = "ID of the security group used for web servers"
  value       = module.web_server_sg.security_group_id
}
