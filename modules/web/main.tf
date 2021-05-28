# DOCS: https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest
module "asg_web" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"

  name = var.asg_name

  # Autoscaling size
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.subnets
  availability_zone         = var.availability_zones

  use_lt                 = true
  create_lt              = true
  lt_name                = var.launch_template_name
  description            = var.launch_template_description
  update_default_version = true

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  image_id          = var.ami_id
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true

  tags_as_map = var.tags
}
