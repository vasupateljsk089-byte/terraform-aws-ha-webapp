resource "aws_lb" "alb" {
  name               = "${var.alb_name}-alb-${var.environment}"
  internal           = var.internal
  load_balancer_type = "application"

  security_groups = [var.security_group_id]
  subnets          = var.subnets

  tags = var.common_tags
}