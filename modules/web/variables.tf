variable "asg_name" {
  description = "Name of the autoscaling group"
  type        = string
  default     = "clod2021-g5pw-web"
}

variable "min_size" {
  description = "Minimum number of instances running in the Autoscaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances running in the Autoscaling group"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired capacity of instances (?)"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "Subnets involved in the autoscaling group"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones involved in the autoscaling group"
  type        = list(string)
}

variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
  default     = "clod2021-g5pw-lt"
}

variable "launch_template_description" {
  description = "Description of the launch template"
  type        = string
  default     = "Launch configuration used for SiouxSilos project by 10kloud"
}

variable "ami_id" {
  description = "ID of the AMI to install in the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}
