output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnets
}

output "vpc_private_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.private_subnets
}

output "vpc_intra_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.intra_subnets
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}
