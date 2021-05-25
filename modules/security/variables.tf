variable "vpc_id" {
  description = "ID of the VPC in which create the resource"
  type        = string
}

variable "web_server_ingress_cidr_blocks" {
  description = "Cidr blocks to use in ingress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
}

variable "vpc_intra_subnets" {
  description = "Isolate subnets for VPC"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to VPC"
  type        = map(string)
}

