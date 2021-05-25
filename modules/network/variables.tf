variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "clod2021-g5pw-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.100.0/24", "10.0.101.0/24"]
}

variable "vpc_intra_subnets" {
  description = "Isolate subnets for VPC"
  type        = list(string)
  default     = ["10.0.200.0/24", "10.0.201.0/24"]
}

variable "tags" {
  description = "Tags to apply to VPC"
  type        = map(string)
}
