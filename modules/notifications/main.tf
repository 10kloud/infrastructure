resource "aws_sns_topic" "user_updates" {
  name         = var.topic_name
  display_name = var.display_name

  tags = var.tags
}
