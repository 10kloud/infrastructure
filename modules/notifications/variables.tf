variable "topic_name" {
  description = "Topic used for alerting siouxsilos teams"
  type        = string
  default     = "clod2021-g5pw-alerts"
}

variable "display_name" {
  description = "Display name for the topic"
  type        = string
  default     = "SiouxSilos Alerts"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Project   = "SiouxSilos"
  }
}
